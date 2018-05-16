//
//  SearchPhotoViewController.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/4/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

class SearchPhotoViewController: UIViewController, ViewControllerSetupable {
    
    //MARK: VARIABLES
    
    var currentDevice: Device!
    
    var allocator: Allocatable.Type!
    var coordinator: Coordinatable.Type!
    
    var collectionView: UICollectionView!
    
    var imagesArray = [UIImage]()

    var hasAppearedAlready = false
    
    var selectedImageIndexPath: IndexPath?
    
    var reloadProfileRecipesDelegate: UpdateProfileRecipesDelegate!
    
    //MARK: UI VIEWS
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .appOffWhite
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "BrowseImage").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .appOffWhite
        button.addTarget(self, action: #selector(searchForPhotos), for: .touchUpInside)
        return button
    }()
    
    let searchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appBluishGray
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.isHidden = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = .appLightRed
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    //MARK: VIEW LIFECYCLE
    
    init(delegate: UpdateProfileRecipesDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.reloadProfileRecipesDelegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        setupSceneFlow()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !hasAppearedAlready {
            conformLayoutToDisplay(size: UIScreen.main.bounds.size)
            hasAppearedAlready = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        conformLayoutToDisplay(size: UIScreen.main.bounds.size)
    }
    
    //MARK: OVERRIDES
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: PROTOCOL-GIVEN FUNCTIONALITY
    
    func setupSceneFlow() {
        let viewController = self
        let allocator = SearchPhotoAllocator.self
        let coordinator = SearchPhotoCoordinator.self
        let presenter = SearchPhotoPresenter.self
        let alertHandler = SearchPhotoAlertHandler.self
        presenter.viewController = viewController
        presenter.alertHandler = alertHandler
        allocator.presenter = presenter
        coordinator.viewController = viewController
        viewController.allocator = allocator
        viewController.coordinator = coordinator
    }
    
    func fetchViewModel(_ viewModel: ViewModel) {
        switch viewModel {
        case let searchImage as SearchImage:
            handlePhotoViewModel(searchImage)
        case let stopActivityIndicatorWithSync as StopActivityIndicatorWithSync:
            handleStopActivityIndicatorWithSyncViewModel(stopActivityIndicatorWithSync)
        case let alertDisplay as AlertDisplay:
            handleAlertDisplayViewModel(alertDisplay)
        default: return
        }
    }
    
    //MARK: FETCH VIEW MODEL CHILD FUNCTIONS
    
    private func handlePhotoViewModel(_ searchImage: UIImage) {
        imagesArray.append(searchImage)
        
        DispatchQueue.main.sync {
            collectionView.insertItems(at: [[0, imagesArray.count - 1 ]])
        }
    }
    
    private func handleStopActivityIndicatorWithSyncViewModel(_ stopActivityIndicatorWithSync: StopActivityIndicatorWithSync) {
        if stopActivityIndicatorWithSync.bool {
            DispatchQueue.main.sync {
                activityIndicator.isHidden = true
                activityIndicator.removeFromSuperview()
                searchButton.setImage(#imageLiteral(resourceName: "BrowseImage").withRenderingMode(.alwaysOriginal), for: .normal)
            }
        } else {
            activityIndicator.isHidden = true
            activityIndicator.removeFromSuperview()
            searchButton.setImage(#imageLiteral(resourceName: "BrowseImage").withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    private func handleAlertDisplayViewModel(_ alertDisplay: AlertDisplay) {
        presentAlert(title: alertDisplay.title, alertMessage: alertDisplay.message, UIViewController: self, completion: nil)
    }
    
    //MARK: VIEW SETUP FUNCTIONS
    
    private func setupView() {
        view.backgroundColor = .blue
        navigationItem.title = SearchPhotoConstants.Titles.navBar.string
        setupCollectionView()
        view.addSubview(containerView)
        [searchContainerView, collectionView].forEach { containerView.addSubview($0)}
        [searchTextField, searchButton].forEach { searchContainerView.addSubview($0)}
        setupBarButtonItems()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .appBrown
        collectionView.register(SearchPhotoCell.self, forCellWithReuseIdentifier: SearchPhotoConstants.CellNames.searchPhotoCell.string)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupBarButtonItems() {
        setupLeftBarButtonItem()
    }
    
    private func setupLeftBarButtonItem() {
        let barButton = UIBarButtonItem(title: AddPhotoConstants.Titles.leftBarButton.string, style: .plain, target: self, action: #selector(performCancelation))
        barButton.setTitleTextAttributes([ .font: UIFont(name: AppFonts.normal.string, size: 14)!], for: .normal)
        navigationItem.leftBarButtonItem = barButton
    }
        
    //MARK: UI USER ACTIONS
    
    @objc private func searchForPhotos(_ sender: UIButton) {
        searchButton.setImage(nil, for: .normal)
        searchButton.addSubview(activityIndicator)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        searchTextField.resignFirstResponder()
        selectedImageIndexPath = nil
        imagesArray.removeAll()
        collectionView.reloadData()
        
        let request = Request(assignment: PhotoSearchAssignment.searchForPhotos, model: searchTextField.text)
        allocator.fetchRequest(request)
    }
    
    @objc private func performCancelation(_ sender: UIBarButtonItem) {
        coordinator.transition(nil, with: nil)
    }
}

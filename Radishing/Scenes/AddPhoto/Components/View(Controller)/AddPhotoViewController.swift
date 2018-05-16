//
//  AddPhotoViewController.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit
import Photos

protocol SelectedImageDisplayDelegate {
    func displaySelectedImage(_ image: UIImage?)
    func sendImage() -> UIImage?
}

class AddPhotoViewController: UIViewController, ViewControllerSetupable {
    
    //MARK: VARIABLES
    
    var currentDevice: Device!
    
    var allocator: Allocatable.Type!
    var coordinator: Coordinatable.Type!
    
    var collectionView: UICollectionView!
    
    var selectedImageDisplayDelegate: SelectedImageDisplayDelegate?
    
    var photosArray = [UIImage]()
    var assetsArray = [PHAsset]()
    
    var reloadProfileRecipesDelegate: UpdateProfileRecipesDelegate!
    
    var hasAppearedAlready = false
    
    //MARK: UI VIEWS
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appOffWhite
        return view
    }()
    
    let selectedPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .cyan
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return UIImageView()
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
        setupSceneFlow()
        setupView()
        let photoRequest = Request(assignment: PhotoRetrievalAssignment.fetchPhotos, model: nil)
        allocator?.fetchRequest(photoRequest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !hasAppearedAlready {
            conformLayoutToDisplay(size: UIScreen.main.bounds.size)
            hasAppearedAlready = true
        }
        
        if photosArray.isEmpty {
            let photoRequest = Request(assignment: PhotoRetrievalAssignment.fetchPhotos, model: nil)
            allocator?.fetchRequest(photoRequest)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        conformLayoutToDisplay(size: UIScreen.main.bounds.size)
    }
    
    //MARK: OVERRRIDES
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: PROTOCOL-GIVEN FUNCTIONALITY
    
    func setupSceneFlow() {
        let viewController = self
        let allocator = AddPhotoAllocator.self
        let presenter = AddPhotoPresenter.self
        let coordinator = AddPhotoCoordinator.self
        let alertHandler = AddPhotoAlertHandler.self
        viewController.allocator = allocator
        viewController.coordinator = coordinator
        allocator.presenter = presenter
        presenter.viewController = viewController
        presenter.alertHandler = alertHandler
        coordinator.viewController = viewController
    }
    
    func fetchViewModel(_ viewModel: ViewModel) {
        switch viewModel {
        case let photosAndAssets as PhotosAndAssets:
            handlePhotosAndAssetsViewModel(photosAndAssets)
        case let image as UIImage:
            handleImageViewModel(image)
        case let alertDisplay as AlertDisplay:
            handleAlertDisplayViewModel(alertDisplay)
        default: return
        }
    }
    
    //MARK: FETCH VIEW MODEL CHILD FUNCTIONS
    
    private func handlePhotosAndAssetsViewModel(_ info: PhotosAndAssets) {
        photosArray = info.photos
        assetsArray = info.assets
        
        DispatchQueue.main.sync {
            //clipToBounds and contentMode only seem to be activate when assigned here rather than in the initialization, even when the content modes are changed in the Photo Retrieval Service.
            selectedPhotoImageView.clipsToBounds = true
            selectedPhotoImageView.contentMode = .scaleAspectFill
            collectionView.reloadData()
        }
    }
    
    private func handleImageViewModel(_ image: UIImage) {
        selectedImageDisplayDelegate?.displaySelectedImage(image)
        selectedPhotoImageView.image = image
    }
    
    private func handleAlertDisplayViewModel(_ alertDisplay: AlertDisplay) {
        presentAlert(title: alertDisplay.title, alertMessage: alertDisplay.message, UIViewController: self, completion: nil)
    }
    
    //MARK: VIEW SETUP FUNCTIONS
    
    private func setupView() {
        view.backgroundColor = .appLightGreen
        
        setupCollectionView()
        setupNavigationButtons()
        setupNavigationBar()
        setupBackButton()
        
        view.addSubview(containerView)
        containerView.addSubview(selectedPhotoImageView)
        containerView.addSubview(collectionView)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .appBluishGray
        collectionView.register(AddPhotoCell.self, forCellWithReuseIdentifier: AddPhotoConstants.CellNames.addPhotoCell.string)
        collectionView.register(AddPhotoHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: AddPhotoConstants.CellNames.addPhotoHeader.string)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .appLightRed
        navigationController?.navigationBar.barTintColor = .appOffWhite
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = AddPhotoConstants.Titles.navBar.string
        navigationController?.navigationBar.titleTextAttributes = [ .font: UIFont(name: AppFonts.fancy.string, size: 20)!]
    }
    
    private func setupNavigationButtons() {
        createLeftNavigationButton()
        createRightNavigationButton()
    }
    
    private func createLeftNavigationButton() {
        let barButton = UIBarButtonItem(title: AddPhotoConstants.Titles.leftBarButton.string, style: .plain, target: self, action: #selector(performCancelation))
        barButton.setTitleTextAttributes([ .font: UIFont(name: AppFonts.normal.string, size: 14)!], for: .normal)
        navigationItem.leftBarButtonItem = barButton
    }
    
    private func createRightNavigationButton() {
        let barButton = UIBarButtonItem(title: AddPhotoConstants.Titles.rightBarButton.string, style: .plain, target: self, action: #selector(performContinuation))
        barButton.setTitleTextAttributes([ .font: UIFont(name: AppFonts.normal.string, size: 14)!], for: .normal)
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func setupBackButton() {
        navigationController?.navigationItem.backBarButtonItem?.title = AddPhotoConstants.Titles.backButton.string
        navigationController?.navigationItem.backBarButtonItem?.setTitleTextAttributes([ .font: UIFont(name: AppFonts.normal.string, size: 14)!], for: .normal)
    }
    
    //MARK: UI USER ACTIONS
    
    @objc private func performContinuation(_ sender: UIBarButtonItem) {
        guard let image = selectedImageDisplayDelegate?.sendImage() else { return }
        coordinator.transition(.createRecipe, with: [AddPhotoConstants.CoordinatorInfoKeys.image.string : image])
    }
    
    @objc private func performCancelation(_ sender: UIBarButtonItem) {
        coordinator.transition(nil, with: nil)
    }
}

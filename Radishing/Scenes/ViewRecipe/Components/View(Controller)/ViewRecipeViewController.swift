//
//  ViewRecipeViewController.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/2/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

class ViewRecipeViewController: UIViewController, ViewControllerSetupable {
    
    //MARK: VARIABLES
    
    var currentDevice: Device!
    
    var allocator: Allocatable.Type!
    var coordinator: Coordinatable.Type!
    
    var indexPath: IndexPath!
    
    var hasAppearedAlready = false
    
    var delegate: UpdateProfileRecipesDelegate!
    
    var user: User!
    
    var recipe: Recipe! {
        didSet {
            textView.text = recipe.recipeText
        }
    }
    
    var recipeImage: UIImage! {
        didSet {
            imageView.image = recipeImage
        }
    }
    
    //MARK: UI VIEWS
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        return textView
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
    
    init(recipe: Recipe, recipeImage: UIImage, user: User, delegate: UpdateProfileRecipesDelegate, indexPath: IndexPath) {
        super.init(nibName: nil, bundle: nil)
        
        // using the defer gives activates property observers upon initial initialization.
        defer {
            self.recipe = recipe
            self.recipeImage = recipeImage
        }
        
        self.recipe = recipe
        self.recipeImage = recipeImage
        self.user = user
        self.delegate = delegate
        self.indexPath = indexPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    //MARK: OVERRRIDES
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: PROTOCOL-GIVEN FUNCTIONALITY
    
    func setupSceneFlow() {
        let viewController = self
        let allocator = ViewRecipeAllocator.self
        let coordinator = ViewRecipeCoordinator.self
        let presenter = ViewRecipePresenter.self
        let alertHandler = ViewRecipeAlertHandler.self
        viewController.allocator = allocator
        viewController.coordinator = coordinator
        allocator.presenter = presenter
        presenter.viewController = viewController
        presenter.alertHandler = alertHandler
        coordinator.viewController = viewController
    }
    
    func fetchViewModel(_ viewModel: ViewModel) {
        activityIndicator.isHidden = true
        activityIndicator.removeFromSuperview()
        view.alpha = 1
        view.isUserInteractionEnabled = true
        navigationItem.rightBarButtonItem?.isEnabled = true
        navigationItem.leftBarButtonItem?.isEnabled = true
        
        switch viewModel {
        case let success as Success:
            handleSuccessViewModel(success)
        case let alertDisplay as AlertDisplay:
            handleAlertDisplayViewModel(alertDisplay)
        default: return
        }
    }
    
    //MARK: FETCH VIEW MODEL CHILD FUNCTIONS
    
    private func handleSuccessViewModel(_ success: Success) {
        let info = [ViewRecipeConstants.CoordinatorInfoKeys.success.string : success.bool]
        coordinator.transition(nil, with: info)
    }
    
    private func handleAlertDisplayViewModel(_ alertDisplay: AlertDisplay) {
        presentAlert(title: alertDisplay.title, alertMessage: alertDisplay.message, UIViewController: self, completion: nil)
    }
    
    //MARK: VIEW SETUP FUNCTIONS
    
    private func setupView() {
        view.backgroundColor = .appLightGreen
        setupNavigationBarItems()
        view.addSubview(imageView)
        view.addSubview(textView)
        navigationItem.title = ViewRecipeConstants.Titles.navigationBar.string
        navigationController?.navigationBar.titleTextAttributes = [ .font: UIFont(name: AppFonts.fancy.string, size: 20)!]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .appOffWhite
    }
    
    private func setupNavigationBarItems() {
        setupLeftBarButtonItem()
        setupRightBarButtonItem()
    }
    
    private func setupLeftBarButtonItem() {
        let barButton = UIBarButtonItem(title: ViewRecipeConstants.Titles.leftBarButton.string, style: .plain, target: self, action: #selector(proceedToDismiss))
        barButton.setTitleTextAttributes([ .font: UIFont(name: AppFonts.normal.string, size: 14)!], for: .normal)
        barButton.tintColor = .appLightRed
        navigationItem.leftBarButtonItem = barButton
    }
    
    private func setupRightBarButtonItem() {
        let barButton = UIBarButtonItem(title: ViewRecipeConstants.Titles.rightBarButton.string, style: .plain, target: self, action: #selector(proceedToDelete))
        barButton.setTitleTextAttributes([ .font: UIFont(name: AppFonts.normal.string, size: 14)!], for: .normal)
        barButton.tintColor = .appLightRed
        navigationItem.rightBarButtonItem = barButton
    }
    
    //MARK: UI USER ACTIONS
    
    @objc private func proceedToDismiss(_ sender: UIBarButtonItem) {
        coordinator.transition(nil, with: nil)
    }
    
    @objc private func proceedToDelete(_ sender: UIBarButtonItem) {
        view.isUserInteractionEnabled = false
        view.alpha = 0.5
        view.addSubview(activityIndicator)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
        
        let recipeDeletionInfo = RecipeDeletionInfo(user: user, recipe: recipe)
        let request = Request(assignment: DatabaseAssignment.deleteRecipe, model: recipeDeletionInfo)
        allocator.fetchRequest(request)
    }
}

//
//  CreateRecipeViewController.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/27/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

protocol UpdateProfileRecipesDelegate {
    func insertRecipe(_ recipe: Recipe)
    func deleteRecipe(at indexPath: IndexPath)
}

class CreateRecipeViewController: UIViewController, ViewControllerSetupable {
    
    //MARK: VARIABLES
    
    var currentDevice: Device!
    
    var allocator: Allocatable.Type!
    var coordinator: Coordinatable.Type!
    
    var reloadProfileRecipesDelegate: UpdateProfileRecipesDelegate!
    
    var hasAppearedAlready = false
    
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
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.isHidden = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = .appLightRed
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGreen
        return view
    }()
    
    lazy var accessoryView: UIView = {
        let accessoryView = UIView()
        accessoryView.backgroundColor = .appBrown
        accessoryView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
        
        accessoryView.addSubview(writingTextView)
        
        //information about the custom operators can be found in the CustomOperators file. The |> and >>> are taken from functional languages. Will look into refactoring views using them and wrapper functions for increased brevity.
        
        let writingTextViewConstraints = topConstraint(of: 15, equalTo: accessoryView.topAnchor)
                                            >>> bottomConstraint(of: -15, equalTo: accessoryView.bottomAnchor)
                                            >>> leftConstraint(of: 30, equalTo: accessoryView.leftAnchor)
                                            >>> rightConstraint(of: -30, equalTo: accessoryView.rightAnchor)
                                            >>> allowForCustomConstraints(true)
        
        let _ = writingTextView |> writingTextViewConstraints
        writingTextView.layer.cornerRadius = 10
        
        return accessoryView
    }()
    
    let writingTextView: RecipeTextView = {
        let textView = RecipeTextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return accessoryView
        }
    }
    
    //MARK: VIEW LIFECYCLE
    
    init(delegate: UpdateProfileRecipesDelegate, recipeImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        
        // using the defer activates property observers upon initial initialization.
        defer { self.recipeImage = recipeImage }
        
        self.reloadProfileRecipesDelegate = delegate
        self.recipeImage = recipeImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSceneFlow()
        setupView()
        addKeyboardDismissGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications(true)
        tabBarController?.tabBar.isHidden = true
        
        if !hasAppearedAlready {
            conformLayoutToDisplay(size: UIScreen.main.bounds.size)
            hasAppearedAlready = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        conformLayoutToDisplay(size: UIScreen.main.bounds.size)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        subscribeToKeyboardNotifications(false)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: OVERRIDES
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    //MARK: PROTOCOL-GIVEN FUNCTIONALITY
    
    func setupSceneFlow() {
        let viewController = self
        let allocator = CreateRecipeAllocator.self
        let coordinator = CreateRecipeCoordinator.self
        let presenter = CreateRecipePresenter.self
        let alertHandler = CreateRecipeAlertHandler.self
        viewController.allocator = allocator
        viewController.coordinator = coordinator
        presenter.alertHandler = alertHandler
        allocator.presenter = presenter
        presenter.viewController = viewController
        coordinator.viewController = viewController
    }
    
    func fetchViewModel(_ viewModel: ViewModel) {
        if let recipeForm = viewModel as? RecipeForm {
            self.handleRecipeFormViewModel(recipeForm)
        } else {
            UIView.animate(withDuration: 0.5, animations: { [unowned self] in
                self.containerView.alpha = 1
            }) { [unowned self] (bool) in
                self.activityIndicator.isHidden = true
                self.activityIndicator.removeFromSuperview()
                self.view.isUserInteractionEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.backBarButtonItem?.isEnabled = true
                
                switch viewModel {
                case let recipe as Recipe:
                    self.handleRecipeViewModel(recipe)
                case let alertDisplay as AlertDisplay:
                    self.handleAlertDisplayViewModel(alertDisplay)
                default: return
                }
            }
        }
    }
    
    //MARK: FETCH VIEW MODEL CHILD FUNCTIONS:
    
    private func handleAlertDisplayViewModel(_ alertDisplay: AlertDisplay) {
        presentAlert(title: alertDisplay.title, alertMessage: alertDisplay.message, UIViewController: self, completion: nil)
    }
    
    private func handleRecipeFormViewModel(_ recipeForm: RecipeForm) {
        let request = Request(assignment: DatabaseAssignment.createRecipe, model: recipeForm)
        allocator.fetchRequest(request)
    }
    
    private func handleRecipeViewModel(_ recipe: Recipe) {
        let info = [CreateRecipeConstants.CoordinatorInfoKeys.recipe.string : recipe]
        coordinator.transition(nil, with: info)
    }
    
    //MARK: VIEW SETUP FUNCTIONS
    
    private func setupView() {
        view.backgroundColor = .appLightGreen
        setupTitle()
        setupNavigationBarItems()
        writingTextView.delegate = self
        view.addSubview(containerView)
        containerView.addSubview(imageView)
    }
    
    private func setupNavigationBarItems() {
        let barButton = UIBarButtonItem(title: CreateRecipeConstants.Titles.rightBarButton.string, style: .plain, target: self, action: #selector(proceedToShare))
        barButton.setTitleTextAttributes([ .font: UIFont(name: AppFonts.normal.string, size: 14)!], for: .normal)
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func setupTitle() {
        navigationItem.title = CreateRecipeConstants.Titles.navigationBar.string
        navigationController?.navigationBar.titleTextAttributes = [ .font: UIFont(name: AppFonts.fancy.string, size: 20)!, .foregroundColor: UIColor.appPink]
    }
    
    //MARK: OTHER CHILD FUNCTIONS
    
    private func addKeyboardDismissGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(lowerKeyboard))
        swipeGesture.direction = .down
        accessoryView.addGestureRecognizer(swipeGesture)
    }
    
    private func createValidateRecipeFormRequest() {
        let recipeCheck = RecipeCheck(image: imageView.image, text: writingTextView.text)
        let request = Request(assignment: DatabaseAssignment.validateRecipeForm, model: recipeCheck)
        allocator.fetchRequest(request)
    }
    
    //MARK: UI USER ACTIONS
    
    @objc private func proceedToShare(_ sender: UIBarButtonItem) {
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.backBarButtonItem?.isEnabled = false
        view.isUserInteractionEnabled = false
        containerView.addSubview(self.activityIndicator)
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.containerView.alpha = 0.5
        }) { [unowned self] (bool) in
            self.createValidateRecipeFormRequest()
        }
    }
    
    @objc private func lowerKeyboard(_ sender: UISwipeGestureRecognizer) {
        writingTextView.resignFirstResponder()
    }
}

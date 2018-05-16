//
//  RandomViewController.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/24/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

protocol ProfileInfoDisplayDelegate {
    func fetchInfo(view: ProfileView, info: Any)
}

enum ProfileView {
    case displayName
    case profilePhoto
    case recipeCount
}

class ProfileViewController: UIViewController, ViewControllerSetupable, ChangeLayoutDelegate, UpdateProfileRecipesDelegate {
    
    //MARK: VARIABLES
    
    var currentDevice: Device!
    
    var allocator: Allocatable.Type!
    var coordinator: Coordinatable.Type!
    
    var profileInfoDisplayDelegate: ProfileInfoDisplayDelegate?
    
    var collectionView: UICollectionView!
    
    var userImage: UIImage?
    
    var isGrid = true
    var gridItemSize: CGFloat!
    
    var currentUser: User?
    var userRecipes = [Recipe]()
    var recipeImages = [StorageURL : UIImage]()
    
    var hasAppearedAlready = false
    
    //MARK: UI VIEWS
    
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let profileLandscapeView: UIView = {
        let view = UIView()
        view.backgroundColor = .appLightGreen
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .appOffWhite
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let recipesLabel: UILabel = {
        let label = UILabel()
        label.text = ProfileConstants.Titles.recipes.string
        label.font = UIFont(name: AppFonts.fancy.string, size: 15)
        label.textAlignment = .center
        label.textColor = .appBluishGray
        return label
    }()
    
    let recipesCountLabel: UILabel = {
        let label = UILabel()
        label.text = ProfileConstants.Titles.count.string
        label.font = UIFont(name: AppFonts.fancy.string, size: 15)
        label.textAlignment = .center
        label.textColor = .appLightRed
        return label
    }()
    
    //MARK: VIEW LIFECYCLE
    
    init(currentUser: User?) {
        super.init(nibName: nil, bundle: nil)
        self.currentUser = currentUser
        setupSceneFlow()
        produceDisplayName()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchRecipes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !hasAppearedAlready {
            conformLayoutToDisplay(size: UIScreen.main.bounds.size)
            produceProfileImage()
            hasAppearedAlready = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        conformLayoutToDisplay(size: UIScreen.main.bounds.size)
    }
    
    //MARK: PROTOCOL-GIVEN FUNCTIONALITY
    
    func setupSceneFlow() {
        let viewController = self
        let allocator = ProfileAllocator.self
        let presenter = ProfilePresenter.self
        let coordinator = ProfileCoordinator.self
        let alertHandler = ProfileAlertHandler.self
        viewController.allocator = allocator
        viewController.coordinator = coordinator
        allocator.presenter = presenter
        presenter.viewController = viewController
        presenter.alertHandler = alertHandler
        coordinator.viewController = viewController
    }
    
    func fetchViewModel(_ viewModel: ViewModel) {
        switch viewModel {
        case let alertDisplay as AlertDisplay:
            handleAlertDisplayViewModel(alertDisplay)
        case let displayName as DisplayName:
            handleDisplayNameViewModel(displayName)
        case let profileImage as UIImage:
            handleProfileImage(profileImage)
        case is SignOutSuccess:
            handleContinueToSignInControllerViewModel()
        case let recipes as OptionalRecipes:
            handleOptionalRecipesViewModel(recipes)
        default: return
        }
    }
    
    func changeToGridView() {
        isGrid = true
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: gridItemSize, height: gridItemSize)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.headerReferenceSize = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).headerReferenceSize
        collectionView.collectionViewLayout = layout
    }
    
    func changeToListView() {
        isGrid = false
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.headerReferenceSize = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).headerReferenceSize
        collectionView.collectionViewLayout = layout
    }
    
    func insertRecipe(_ recipe: Recipe) {
        userRecipes.insert(recipe, at: 0)
        collectionView.insertItems(at: [[0, 0]])
        changeRecipeCount(by: 1)
    }
    
    func deleteRecipe(at indexPath: IndexPath) {
        userRecipes.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        changeRecipeCount(by: -1)
    }
    
    
    //MARK: FETCH VIEW MODEL CHILD FUNCTIONS
    
    private func handleAlertDisplayViewModel(_ alertDisplay: AlertDisplay) {
        presentAlert(title: alertDisplay.title, alertMessage: alertDisplay.message, UIViewController: self, completion: nil)
    }
    
    private func handleDisplayNameViewModel(_ displayName: DisplayName) {
        navigationItem.title = displayName.string
        profileInfoDisplayDelegate?.fetchInfo(view: .displayName, info: displayName.string)
    }
    
    private func handleProfileImage(_ profileImage: UIImage) {
        userImage = profileImage
        DispatchQueue.main.sync {
            profileImageView.image = profileImage
        }
        profileInfoDisplayDelegate?.fetchInfo(view: .profilePhoto, info: profileImage)
    }
    
    private func handleContinueToSignInControllerViewModel() {
        coordinator.transition(nil, with: nil)
    }
    
    private func handleOptionalRecipesViewModel(_ recipes: OptionalRecipes) {
        if let recipes = recipes.array {
            self.userRecipes = recipes
            recipesCountLabel.text = "\(recipes.count)"
            profileInfoDisplayDelegate?.fetchInfo(view: .recipeCount, info: recipes.count)
            self.collectionView.reloadData()
        } else {
            self.userRecipes.removeAll()
            recipesCountLabel.text = "0"
            profileInfoDisplayDelegate?.fetchInfo(view: .recipeCount, info: 0)
            self.collectionView.reloadData()
        }
    }
    
    //MARK: VIEW SETUP FUNCTIONS
    
    private func setupView() {
        view.backgroundColor = .appOffWhite
        
        setupCollectionView()
        
        view.addSubview(containerView)
        containerView.addSubview(profileLandscapeView)
        containerView.addSubview(collectionView)
        [profileImageView, recipesLabel, recipesCountLabel].forEach { profileLandscapeView.addSubview($0)}
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(settingsAppear))
    }
    
    private func produceDisplayName() {
        let request = Request(assignment: AuthAssignment.fetchDisplayName, model: nil)
        allocator?.fetchRequest(request)
    }
    
    private func produceProfileImage() {
        guard let storageURL = currentUser?.photoURL else {
            let image = #imageLiteral(resourceName: "BlankProfileImage").withRenderingMode(.alwaysOriginal)
            profileImageView.image = image
            profileInfoDisplayDelegate?.fetchInfo(view: .profilePhoto, info: image)
            return
        }
        
        let photoFetch = PhotoFetch(storageURL: storageURL)
        let request = Request(assignment: OfflineStorageAssignment.fetchData, model: photoFetch)
        allocator?.fetchRequest(request)
    }
    
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .appBrown
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: ProfileConstants.CellNames.recipeCell.string)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ProfileConstants.CellNames.profileHeader.string)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //MARK: OTHER CHILD FUNCTIONS
    
    private func fetchRecipes() {
        guard let id = currentUser?.id else { return }
        let request = Request(assignment: DatabaseAssignment.fetchRecipes, model: id)
        allocator.fetchRequest(request)
    }
    
    private func presentAlertSettingsController() {
        let style: UIAlertControllerStyle = UIDevice().userInterfaceIdiom == .phone ? .actionSheet : .alert
        let settingsController = UIAlertController(title: ProfileConstants.Titles.settings.string, message: nil, preferredStyle: style)
        
        let logOutAction = UIAlertAction(title: ProfileConstants.Titles.logOut.string, style: .destructive) { [unowned self] _ in
            let request = Request(assignment: AuthAssignment.signOut, model: nil)
            self.allocator?.fetchRequest(request)
        }
        
        let cancelAction = UIAlertAction(title: ProfileConstants.Titles.cancel.string, style: .cancel) { _ in }
        
        [logOutAction, cancelAction].forEach {
            settingsController.addAction($0)
        }
        
        present(settingsController, animated: true, completion: nil)
    }
    
    private func changeRecipeCount(by int: Int) {
        if let text = recipesCountLabel.text, let count = Int(text) {
            let newCount = count + int
            recipesCountLabel.text = "\(newCount)"
            profileInfoDisplayDelegate?.fetchInfo(view: .recipeCount, info: newCount)
        }
    }
    
    //MARK: UI USER ACTIONS
    
    @objc func settingsAppear(_ sender: UIBarButtonItem) {
        presentAlertSettingsController()
    }
}

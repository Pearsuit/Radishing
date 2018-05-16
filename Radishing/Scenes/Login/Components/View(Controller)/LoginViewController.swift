//
//  LoginViewController.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, ViewControllerSetupable, FetchNewUserDelegate, WillAnimateSignDelegate {
    
    //MARK: VARIABLES
    
    var allocator: Allocatable.Type!
    var coordinator: Coordinatable.Type!
    
    var currentDevice: Device!
    
    var newUser: User?
    
    var willAnimateSign = true
    var isKeyboardHidden = true
    
    //MARK: UI VIEWS
    
    let rod1: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    let rod2: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        return view
    }()
    
    let backboard: UIView = {
        let view = UIView()
        view.backgroundColor = .appBrown
        view.layer.cornerRadius = 10
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .appOffWhite
        label.text = LoginConstants.ViewTexts.appTitle.string
        label.textColor = .appPink
        label.font = UIFont(name: AppFonts.fancy.string, size: 70)
        label.textAlignment = .center
        label.contentMode = .scaleAspectFit
        label.layer.cornerRadius = 5
        return label
    }()
    
    let screw1: UIView = {
        let view = UIView()
        view.backgroundColor = .appGray
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let screw2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appGray
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let screw3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appGray
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let screw4: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appGray
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let signInLabel: UILabel = {
        let label = UILabel()
        label.text = LoginConstants.ViewTexts.signInLabelTitle.string
        label.textColor = .appBluishGray
        label.font = UIFont(name: AppFonts.fancy.string, size: 35)
        label.textAlignment = .center
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .appOffWhite
        textField.placeholder = LoginConstants.Placeholders.email.string
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .appOffWhite
        textField.placeholder = LoginConstants.Placeholders.password.string
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appLightRed
        button.setTitle(LoginConstants.ViewTexts.signInButtonTitle.string, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: AppFonts.normalBold.string, size: 14)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(performSignIn), for: .touchUpInside)
        return button
    }()
    
    let signUpButton: UIButton = {
        
        let button = UIButton(type: .system)
        
        let firstAttributes: [NSAttributedStringKey : Any] = [
            .font : UIFont.systemFont(ofSize: 14),
            .foregroundColor : UIColor.appOffWhite
        ]
        
        let secondAttributes: [NSAttributedStringKey : Any ] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor : UIColor.appDarkGreen
        ]
        
        let title = NSMutableAttributedString(string: LoginConstants.ViewTexts.signUpPartITitle.string, attributes: firstAttributes)
        
        let appenededString = NSAttributedString(string: LoginConstants.ViewTexts.signUpPartIITitle.string, attributes: secondAttributes)
        title.append(appenededString)
        
        button.setAttributedTitle(title, for: .normal)
        
        button.addTarget(self, action: #selector(goToRegistration), for: .touchUpInside)
        
        return button
    }()
    
    let processingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        return indicator
    }()
    
    //MARK: VIEW LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSceneFlow()
        
        setupView()
        
        conformLayoutToDisplay(size: UIScreen.main.bounds.size)
        
        [emailTextField, passwordTextField].forEach { $0.addTarget(self, action: #selector(trimWhitespaces), for: .editingChanged)}
        [emailTextField, passwordTextField].forEach { $0.delegate = self }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeToKeyboardNotifications(true)
        
        //transitions automatically to MainTabController after signing up and dismissing the sign up view controller
        if let user = newUser {
            coordinator.transition(.mainTab, with: [LoginConstants.CoordinatorInfoKeys.user.string : user])
        } else if !willAnimateSign {
            view.backgroundColor = .appPink
            UIView.animate(withDuration: 0.75) { [unowned self] in
                self.view.backgroundColor = .appLightGreen
            }
        } else if willAnimateSign {
            [rod1, rod2, backboard].forEach { $0.center.y -= view.frame.height }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if newUser == nil {
            if willAnimateSign {
                UIView.animate(withDuration: 1, animations: { [unowned self] in
                    [self.rod1, self.rod2, self.backboard]
                        .forEach { $0.center.y += self.view.frame.height }
                }) { (bool) in
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        subscribeToKeyboardNotifications(false)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        conformLayoutToDisplay(size: size)
    }
    
    //MARK: OVERRIDES
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: PROTOCOL-GIVEN FUNCTIONALITY
    
    func setupSceneFlow() {
        let viewController = self
        let allocator = LoginAllocator.self
        let presenter = LoginPresenter.self
        let coordinator = LoginCoordinator.self
        let alertHandler = LoginAlertHandler.self
        viewController.allocator = allocator
        viewController.coordinator = coordinator
        allocator.presenter = presenter
        presenter.viewController = viewController
        presenter.alertHandler = alertHandler
        coordinator.viewController = viewController
    }
    
    func fetchViewModel(_ viewModel: ViewModel) {
        switch viewModel {
        case let loginForm as LoginForm:
            handleLoginFormViewModel(loginForm)
        case let user as User:
            handleUserViewModel(user)
        case let alertDisplay as AlertDisplay:
            handleAlertDisplayViewModel(alertDisplay)
        default: return
        }
    }
    
    func fetchNewUser(user: User) {
        newUser = user
    }
    
    //MARK: FETCH VIEW MODEL CHILD FUNCTIONS
    
    private func handleLoginFormViewModel(_ loginForm: LoginForm) {
        let request = Request(assignment: AuthAssignment.emailSignIn, model: loginForm)
        allocator.fetchRequest(request)
    }
    
    private func handleUserViewModel(_ user: User) {
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.processingIndicator.stopAnimating()
            self.processingIndicator.removeFromSuperview()
            self.signInButton.backgroundColor = .appLightRed
            }, completion: { [unowned self] (bool) in
                
                [self.signInButton, self.emailTextField, self.passwordTextField].forEach { $0.isEnabled = true }
                
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
                
                self.coordinator.transition(.mainTab, with: [LoginConstants.CoordinatorInfoKeys.user.string : user])
        })
    }
    
    private func handleAlertDisplayViewModel(_ alertDisplay: AlertDisplay) {
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.processingIndicator.stopAnimating()
            self.processingIndicator.removeFromSuperview()
            self.signInButton.backgroundColor = .appLightRed
            }, completion: { [unowned self] (bool) in
                
                [self.signInButton, self.emailTextField, self.passwordTextField].forEach { $0.isEnabled = true }
                
                presentAlert(title: alertDisplay.title, alertMessage: alertDisplay.message, UIViewController: self, completion: nil)
        })
    }
    
    //MARK: VIEW SETUP FUNCTIONS:
    
    private func setupView() {
        view.backgroundColor = .appLightGreen
        
        [rod1, rod2, backboard, signInLabel, emailTextField, passwordTextField, signInButton, signUpButton]
            .forEach { view.addSubview($0)}
        backboard.addSubview(titleLabel)
        [screw1, screw2, screw3, screw4].forEach { titleLabel.addSubview($0)}
    }
    
    //MARK: OTHER CHILD FUNCTIONS
    
    private func createValidSignInFormRequest() {
        let request = Request(assignment: AuthAssignment.validateSignInForm, model: createLoginCheckFromTextFields())
        self.allocator.fetchRequest(request)
    }
    
    private func createLoginCheckFromTextFields() -> LoginCheck {
        let email = emailTextField.text
        let password = passwordTextField.text
        return LoginCheck(email: email, password: password)
    }
    
    //MARK: UI USER ACTIONS
    
    @objc private func performSignIn(_ sender: UIButton) {
        [signInButton, emailTextField, passwordTextField].forEach { $0.isEnabled = false }
        
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.signInButton.addSubview(self.processingIndicator)
            self.processingIndicator.isHidden = false
            self.processingIndicator.startAnimating()
            self.signInButton.backgroundColor = .lightGray
            
        }) { [unowned self] (bool) in
            self.createValidSignInFormRequest()
        }
    }
    
    @objc private func goToRegistration(_ sender: UIButton) {
        self.emailTextField.text = nil
        self.passwordTextField.text = nil
        
        willAnimateSign = false
        coordinator.transition(.signup, with: nil)
    }
    
    @objc private func trimWhitespaces(_ sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

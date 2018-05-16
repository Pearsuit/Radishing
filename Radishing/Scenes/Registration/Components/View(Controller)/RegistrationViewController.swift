//
//  RegistrationViewController.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

protocol FetchNewUserDelegate {
    func fetchNewUser(user: User)
}

enum SignInTextField {
    case email
    case username
    case password
    case reEnterPassword
}

class RegistrationViewController: UIViewController, ViewControllerSetupable, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: VARIABLES and TYPEALIASES
    
    var allocator: Allocatable.Type!
    var coordinator: Coordinatable.Type!
    
    var currentDevice: Device!
    
    var fetchNewUserDelegate: FetchNewUserDelegate!
    
    var isKeyboardHidden = true
    
    var currentTextField: SignInTextField?
    
    //MARK: UI VIEWS
    
    let photoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "BlankProfileImage").withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .appOffWhite
        button.imageView?.contentMode = .scaleAspectFill
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.appLightGreen.cgColor
        button.tag = 210
        return button
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "BackButtonImage").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(returnToSignInView), for: .touchUpInside)
        button.tag = 211
        return button
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = RegistrationConstants.Placeholders.email.string
        textField.backgroundColor = .appOffWhite
        textField.borderStyle = .roundedRect
        textField.tag = 220
        return textField
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = RegistrationConstants.Placeholders.username.string
        textField.backgroundColor = .appOffWhite
        textField.borderStyle = .roundedRect
        textField.tag = 221
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = RegistrationConstants.Placeholders.password.string
        textField.backgroundColor = .appOffWhite
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.tag = 222
        return textField
    }()
    
    let reEnterPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = RegistrationConstants.Placeholders.reEnterPassword.string
        textField.backgroundColor = .appOffWhite
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.tag = 223
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(RegistrationConstants.Titles.signUpButtonDeactivated.string, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont(name: AppFonts.normalBold.string, size: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(createSignUpRequest), for: .touchUpInside)
        button.isEnabled = false
        button.tag = 213
        return button
    }()
    
    let processingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        indicator.tag = 290
        return indicator
    }()
    
    //MARK: VIEW LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSceneFlow()
        setupView()
        setupTargetActions()
        
        [emailTextField, usernameTextField, passwordTextField, reEnterPasswordTextField].forEach { $0.delegate = self }
        
        conformLayoutToDisplay(size: UIScreen.main.bounds.size)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications(true)
        UIView.animate(withDuration: 0.75) { [unowned self] in
            self.view.backgroundColor = .appPink
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        subscribeToKeyboardNotifications(false)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        conformLayoutToDisplay(size: size)
    }
    
    //MARK: PROTOCOL-GIVEN FUNCTIONALITY
    
    func setupSceneFlow() {
        let viewController = self
        let allocator = RegistrationAllocator.self
        let presenter = RegistrationPresenter.self
        let coordinator = RegistrationCoordinator.self
        let alertHandler = RegistrationAlertHandler.self
        viewController.allocator = allocator
        viewController.coordinator = coordinator
        allocator.presenter = presenter
        presenter.viewController = viewController
        presenter.alertHandler = alertHandler
        coordinator.viewController = viewController
    }
    
    func fetchViewModel(_ viewModel: ViewModel) {
        switch viewModel {
        case let isCompletForm as IsCompleteForm:
            handleIsCompleteFormViewModel(isCompleteForm: isCompletForm)
        case let registrationForm as RegistrationForm:
            handleRegistrationFormViewModel(registrationForm)
        case let user as User:
            handleUserViewModel(user)
        case let alertDisplay as AlertDisplay:
            handleAlertDisplayViewModel(alertDisplay)
        default: return
        }
    }
    
    //MARK: FETCH VIEW MODEL CHILD FUNCTIONS
    
    private func handleIsCompleteFormViewModel(isCompleteForm: IsCompleteForm) {
        if isCompleteForm.bool {
            if self.signUpButton.backgroundColor != .appLightGreen || self.signUpButton.isEnabled == false {
                
                UIView.animate(withDuration: 0.35, animations: {
                    self.signUpButton.backgroundColor = .appLightGreen
                    self.signUpButton.setTitle(RegistrationConstants.Titles.signUpButtonActivated.string, for: .normal)
                }) { [unowned self] (bool) in
                    self.signUpButton.isEnabled = true
                }
            }
        } else {
            signUpButton.isEnabled = false
            
            if self.signUpButton.backgroundColor != .black {
                UIView.animate(withDuration: 0.35) { [unowned self] in
                    self.signUpButton.backgroundColor = .black
                    self.signUpButton.setTitle(RegistrationConstants.Titles.signUpButtonDeactivated.string, for: .normal)
                }
            }
        }
    }
    
    private func handleRegistrationFormViewModel(_ registrationForm: RegistrationForm) {
        let model = RegistrationForm(email: registrationForm.email, username: registrationForm.username,
                                             password: registrationForm.password, image: photoButton.imageView?.image)
        let request = Request(assignment: AuthAssignment.emailSignUp, model: model)
        self.allocator.fetchRequest(request)
    }
    
    private func handleUserViewModel(_ user: User) {
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.processingIndicator.stopAnimating()
            self.signUpButton.backgroundColor = .appLightGreen
            
            }, completion: { [unowned self] (bool) in
                
                self.fetchNewUserDelegate.fetchNewUser(user: user)
                [self.signUpButton, self.emailTextField, self.usernameTextField, self.passwordTextField, self.reEnterPasswordTextField]
                    .forEach { $0.isEnabled = true }
                self.coordinator.transition(nil, with: nil)
        })
    }
    
    private func handleAlertDisplayViewModel(_ alertDisplay: AlertDisplay) {
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            self.processingIndicator.stopAnimating()
            self.signUpButton.backgroundColor = .appLightGreen
            
            }, completion: { [unowned self] (bool) in
                
                presentAlert(title: alertDisplay.title, alertMessage: alertDisplay.message, UIViewController: self, completion: nil)
                
                [self.signUpButton, self.emailTextField, self.usernameTextField, self.passwordTextField, self.reEnterPasswordTextField]
                    .forEach { $0.isEnabled = true }
        })
    }
    
    //MARK: VIEW SETUP FUNCTIONS:
    
    private func setupView() {
        view.backgroundColor = .appLightGreen
        
        [photoButton, emailTextField, usernameTextField, passwordTextField, reEnterPasswordTextField, signUpButton, dismissButton]
            .forEach { view.addSubview($0) }
        signUpButton.addSubview(processingIndicator)
    }
    
    //MARK: OTHER CHILD FUNCTIONS
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            dismiss(animated: true) { [unowned self] in
                RegistrationAlertHandler.processError(RegistrationError.photoCouldNotBeSet, completion: { (title, message) in
                    presentAlert(title: title, alertMessage: message, UIViewController: self, completion: nil)
                })
            }
            return
        }
        
        photoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    private func createRegistrationCheckFromTextFields() -> RegistrationCheck {
        let email = self.emailTextField.text
        let username = self.usernameTextField.text
        let password = self.passwordTextField.text
        let reEnterPassword = self.reEnterPasswordTextField.text
        return RegistrationCheck(email: email, username: username, password: password, reEnterPassword: reEnterPassword)
    }
    
    private func createValidateSignUpFormRequest() {
        let request = Request(assignment: AuthAssignment.validateSignUpForm, model: createRegistrationCheckFromTextFields())
        self.allocator.fetchRequest(request)
    }
    
    private func setupTargetActions() {
        [emailTextField, usernameTextField, passwordTextField, reEnterPasswordTextField]
            .forEach { $0.addTarget(self, action: #selector(checkForCompleteForm), for: .editingChanged) }
        
        photoButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        
        [emailTextField, usernameTextField, passwordTextField, reEnterPasswordTextField]
            .forEach { $0.addTarget(self, action: #selector(trimWhitespaces), for: .editingChanged)}
        
        [emailTextField, usernameTextField, passwordTextField, reEnterPasswordTextField]
            .forEach { $0.addTarget(self, action: #selector(identifyTextField), for: .editingDidBegin)}
        
        [usernameTextField, passwordTextField, reEnterPasswordTextField]
            .forEach { $0.addTarget(self, action: #selector(checkTextFieldTextLength), for: .editingChanged)}
    }
    
    //MARK: UI USER ACTIONS
    
    @objc private func createSignUpRequest(_ sender: UIButton) {
        [signUpButton, emailTextField, usernameTextField, passwordTextField, reEnterPasswordTextField]
            .forEach { $0.isEnabled = false }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.processingIndicator.isHidden = false
            self.processingIndicator.startAnimating()
            self.signUpButton.backgroundColor = .appGreenishGray
        }) { [unowned self] (bool) in
            self.createValidateSignUpFormRequest()
        }
    }
    
    @objc private func checkForCompleteForm(_ sender: UITextField) {
        let request = Request(assignment: AuthAssignment.checkForCompleteSignUpForm, model: createRegistrationCheckFromTextFields())
        allocator.fetchRequest(request)
    }
    
    @objc private func addPhoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc private func returnToSignInView(_ sender: UIButton) {
        coordinator.transition(nil, with: nil)
    }
    
    @objc private func trimWhitespaces(_ sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    @objc private func checkTextFieldTextLength(_ sender: UITextField) {
        switch sender.tag {
        case 221:
            if let count = sender.text?.count, count > 21 {
                sender.text?.removeLast()
            }
        case 222, 223:
            if let count = sender.text?.count, count > 15 {
                sender.text?.removeLast()
            }
        default: return
        }
    }
    
    @objc private func identifyTextField(_ sender: UITextField) {
        switch sender {
        case emailTextField:
            currentTextField = .email
        case usernameTextField:
            currentTextField = .username
        case passwordTextField:
            currentTextField = .password
        case reEnterPasswordTextField:
            currentTextField = .reEnterPassword
        default: return
        }
    }
}

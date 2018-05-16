//
//  RegistrationAuthProducer.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import Photos

enum RegistrationAuthProducer: AuthProducerSetupable {
    
    //MARK: PARENT FUNCTION
    
    static var presenter: Presentable.Type!
    static var authenticator: Authenticatable.Type!
    
    static func fetchWork(_ work: Work) {
        presenter = work.presenter
        self.authenticator = CurrentServices.authenticator
        let assignment = work.assignment as! AuthAssignment
        selectAuthTask(assignment, with: work.model)
    }
    
    //MARK: CHILD FUNCTIONS
    
    private static func selectAuthTask(_ assignment: AuthAssignment, with model: RequestModelable?) {
        switch assignment {
        case .checkForCompleteSignUpForm:
            let registrationCheck = model as! RegistrationCheck
            handleCheckForCompleteForm(with: registrationCheck)
        case .validateSignUpForm:
            let registrationCheck = model as! RegistrationCheck
            handleValidateForm(with: registrationCheck)
        case .emailSignUp:
            let registrationForm = model as! RegistrationForm
            emailSignUp(with: registrationForm)
        default: return 
        }
    }
    
    //MARK: CHECK FOR COMPLETE SIGN UP FORM FUNCTIONS
    
    private static func handleCheckForCompleteForm(with registrationCheck: RegistrationCheck) {
        do {
            try checkForCompleteForm(using: registrationCheck)
        } catch {
            let model = IsCompleteForm(bool: false)
            let results = Results(assignment: AuthAssignment.checkForCompleteSignUpForm, error: nil, model: model)
            presenter.fetchResults(results)
        }
    }
    
    private static func checkForCompleteForm(using registrationCheck: RegistrationCheck) throws {
        guard let email = registrationCheck.email, !email.isEmpty,
            let username = registrationCheck.username, !username.isEmpty,
            let password = registrationCheck.password, !password.isEmpty,
            let reEnterPassword = registrationCheck.reEnterPassword ,!reEnterPassword.isEmpty else { throw RegistrationError.incompleteForm }
        
        let model = IsCompleteForm(bool: true)
        let results = Results(assignment: AuthAssignment.checkForCompleteSignUpForm, error: nil, model: model)
        presenter.fetchResults(results)
    }
    
    //MARK: CHECK FOR VALID CORRECT FORM FUNCTIONS
    
    private static func handleValidateForm(with registrationCheck: RegistrationCheck) {
        do {
            try checkForCorrectForm(using: registrationCheck)
        } catch {
            let results = Results(assignment: AuthAssignment.validateSignUpForm, error: error, model: nil)
            presenter.fetchResults(results)
        }
    }
    
    private static func checkForCorrectForm(using registrationCheck: RegistrationCheck) throws {
        
        guard let email = registrationCheck.email, !email.isEmpty,
            let username = registrationCheck.username, !username.isEmpty,
            let password = registrationCheck.password, !password.isEmpty,
            let reEnterPassword = registrationCheck.reEnterPassword,!reEnterPassword.isEmpty else { throw RegistrationError.incompleteForm }
        
        guard validateEmail(email: email) == true else { throw RegistrationError.invalidEmail }
        guard username.count >= 4 else { throw RegistrationError.usernameLength }
        guard password == reEnterPassword else { throw RegistrationError.mismatchedPasswords }
        guard password.count > 6 else { throw RegistrationError.passwordLength }
        
        let registrationForm = RegistrationForm(email: email, username: username, password: password, image: nil)
        let results = Results(assignment: AuthAssignment.validateSignUpForm, error: nil, model: registrationForm)
        presenter.fetchResults(results)
    }
    
    private static func validateEmail(email: String) -> Bool {
        // try! will always succeed since pattern is valid
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
    }
    
    //MARK: EMAIL SIGN UP FUNCTIONS
    
    private static func emailSignUp(with registrationForm: RegistrationForm) {
        let image = registrationForm.image
        var imageData: Data? = nil
        
        if let image = image, image != #imageLiteral(resourceName: "BlankProfileImage").withRenderingMode(.alwaysOriginal){
            if let data = UIImageJPEGRepresentation(image, 0.25) { imageData = data }
        }
        
        self.authenticator.createEmailAuth(email: registrationForm.email, username: registrationForm.username, password: registrationForm.password, data: imageData) { (error, user) in
            let results = Results(assignment: AuthAssignment.emailSignUp, error: error, model: user)
            presenter.fetchResults(results)
        }
    }
}

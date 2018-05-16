//
//  LoginAuthProducer.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/27/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum LoginAuthProducer: AuthProducerSetupable {
    
    //MARK: Properties
    
    static var authenticator: Authenticatable.Type!
    static var presenter: Presentable.Type!
    
    //MARK: Main Function
    
    static func fetchWork(_ work: Work) {
        presenter = work.presenter
        authenticator = CurrentServices.authenticator
        let assignment = work.assignment as! AuthAssignment
        switch assignment {
        case .validateSignInForm:
            let loginCheck = work.model as! LoginCheck
            handleValidateSignInForm(with: loginCheck)
        case .emailSignIn:
            let loginForm = work.model as! LoginForm
            handleEmailSignIn(with: loginForm)
        default: return
        }
    }

    //MARK: Child Functions
    
    private static func handleValidateSignInForm(with loginCheck: LoginCheck) {
        do {
            let loginForm = try createLoginForm(from: loginCheck)
            let results = Results(assignment: AuthAssignment.validateSignInForm, error: nil, model: loginForm)
            presenter.fetchResults(results)
        } catch {
            let results = Results(assignment: AuthAssignment.validateSignInForm, error: error, model: nil)
            presenter.fetchResults(results)
        }
    }
    
    private static func createLoginForm(from loginCheck: LoginCheck) throws -> LoginForm {
        
        guard let email = loginCheck.email, !email.isEmpty else {
            throw LoginError.emptyEmailTextField
        }
        
        guard let password = loginCheck.password, !password.isEmpty else {
            throw LoginError.emptyPasswordTextField
        }
        
        let loginForm = LoginForm(email: email, password: password)
        return loginForm
    }
    
    private static func handleEmailSignIn(with loginForm: LoginForm) {
        authenticator.emailLogin(email: loginForm.email, password: loginForm.password) { (error, user) in
            let results = Results(assignment: AuthAssignment.emailSignIn, error: error, model: user)
            presenter.fetchResults(results)
        }
    }
}

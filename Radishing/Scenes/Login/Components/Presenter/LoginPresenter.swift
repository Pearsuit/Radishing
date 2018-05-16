//
//  LoginPresenter.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum LoginPresenter: PresenterSetupable {
    
    //MARK: Properties
    
    static weak var viewController: ViewControllable!
    static var alertHandler: Alertable.Type!
    
    //MARK: Parent Function
    
    static func fetchResults(_ results: Results) {
        switch results.assignment {
        case let authAssignment as AuthAssignment:
            handleAuthInfo(assignment: authAssignment, error: results.error, info: results.model)
        case let improperAssignment as ImproperAssignment:
            handleImproperAssignment(assignment: improperAssignment, error: results.error!)
        default:
            handleInvalidAssignment()
        }
    }
    
    //MARK: Child Functions
    
    private static func handleAuthInfo(assignment: AuthAssignment, error: Error?, info: ResultsModelable?) {
        switch assignment {
        case .validateSignInForm:
            handleValidateSignInFormViewModel(error: error, info: info)
        case .emailSignIn:
            handleSignInViewModel(error: error, info: info)
        default: return
        }
    }
    
    private static func handleValidateSignInFormViewModel(error: Error?, info: ResultsModelable?) {
        if let error = error {
            sendAlertDisplay(error: error)
        } else if let loginForm = info as? LoginForm {
            CompilerCheckForViewModel(loginForm)
        }
    }
    
    private static func handleSignInViewModel(error: Error?, info: ResultsModelable?) {
        if let error = error {
            sendAlertDisplay(error: error)
        } else if let user = info as? User {
            CompilerCheckForViewModel(user)
        } else {
            let error = LoginError.noData
            sendAlertDisplay(error: error)
        }
    }
    
    private static func handleImproperAssignment(assignment: ImproperAssignment, error: Error) {
        sendAlertDisplay(error: error)
    }
    
    private static func handleInvalidAssignment() {
        let error = ImproperSceneError.invalidAssignmentAtPresenter
        sendAlertDisplay(error: error)
    }
    
    private static func CompilerCheckForViewModel(_ viewModel: ViewModelable) {
        viewController.fetchViewModel(viewModel)
    }
    
    private static func sendAlertDisplay(error: Error) {
        alertHandler.processError(error) { (title, message) in
            let alertDisplay = AlertDisplay(title: title, message: message)
            CompilerCheckForViewModel(alertDisplay)
        }
    }
}

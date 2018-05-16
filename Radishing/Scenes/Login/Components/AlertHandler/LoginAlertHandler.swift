//
//  LoginAlertHandler.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/27/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum LoginAlertHandler: Alertable {
    
    //MARK: PARENT FUNCTION
    
    static func processError(_ error: Error, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        if let error = error as? AuthError {
            handleAuthError(error: error, completion: completion)
        } else if let error = error as? LoginError {
            handleLoginError(error: error, completion: completion)
        } else if let error = error as? ImproperSceneError {
            handleImproperSceneError(error: error, completion: completion)
        }
    }
    
    //MARK: CHILD FUNCTIONS
    
    private static func handleAuthError(error: AuthError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        let title = "Authentication Error"
        switch error {
        case .emailLoginUnsuccessful:
            let message = "The email and password do not match"
            completion(title, message)
        case .emailIsNotRegistered:
            let message = "The email provided is not registered"
            completion(title, message)
        case .emailIsNotProperlyFormatted:
            let message = "The email provided is improperly formatted"
            completion(title, message)
        case .noInternetConnection:
            let message = "No internet connection could be found"
            completion(title, message)
        default: return
        }
    }
    
    private static func handleLoginError(error: LoginError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        let title = "Login Error"
        switch error {
        case .emptyEmailTextField:
            let message = "Please input an email"
            completion(title, message)
        case .emptyPasswordTextField:
            let message = "Please input a password"
            completion(title, message)
        case .emailIsNotRegistered:
            let message = "The email is not registered."
            completion(title, message)
        case .noData:
            let message = "No data on the user could be found"
            completion(title, message)
        }
    }
    
    private static func handleImproperSceneError(error: ImproperSceneError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        let title = "Improper Scene Error"
        switch error {
        case .invalidAssignmentAtAllocator:
            let message = "An invalid assignment occured at the allocator"
            completion(title, message)
        case .invalidAssignmentAtPresenter:
            let message = "An invalid assignment occured at the presenter"
            completion(title, message)
        }
    }
}

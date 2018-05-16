//
//  RegistrationAlertHandler.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/23/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum RegistrationAlertHandler: Alertable {
    
    //MARK: PARENT FUNCTION
    
    static func processError(_ error: Error, completion: @escaping (AlertTitle, AlertMessage) -> Void ){
        if let error = error as? RegistrationError {
            handleRegistrationError(error: error, completion: completion)
        } else if let error = error as? AuthError {
            handleAuthError(error: error, completion: completion)
        } else if let error = error as? ImproperSceneError {
            handleSceneError(error: error, completion: completion)
        } else {
            fatalError("An unknown error has been selected while adding an error. Change the error type or remove it")
        }
    }
    
    //MARK: CHILD FUNCTIONS
    
    private static func handleRegistrationError(error: RegistrationError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        let title = "Registration Error"
        switch error {
        case .incompleteForm:
            let message = "The form is incomplete"
            completion(title, message)
        case .invalidEmail:
            let message = "The email provided is not valid"
            completion(title, message)
        case .mismatchedPasswords:
            let message = "The passwords do not match"
            completion(title, message)
        case .emailTaken:
            let message = "Email is already taken"
            completion(title, message)
        case .photoCouldNotBeSet:
            let message = "Photo could not be set"
            completion(title, message)
        case .passwordLength:
            let message = "Password must have at least 6 characters"
            completion(title, message)
        case .usernameLength:
            let message = "Username must have at least 4 characters"
            completion(title, message)
        case .noUserData:
            let message =  "A new user could not be created. Try again."
            completion(title, message)
        }
    }
    
    private static func handleAuthError(error: AuthError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        let title = "Authentication Error"
        switch error {
        case .createEmailAuthUnsuccessful:
            let message = "Creating email authentication was unsuccessful"
            completion(title, message)
        case .checkIfEmailIsTakenSearchError:
            let message = "Error has occurred while checking if email is taken"
            completion(title, message)
        case .emailAlreadyInUse:
            let message = "Email has already been taken. Please use another email address"
            completion(title, message)
        case .displayNameCreationError:
            let message = "Could not add display name to your authentication"
            completion(title, message)
        case .unknownError:
            let message = "An unknown error has occurred"
            completion(title, message)
        case .emailIsNotProperlyFormatted:
            let message = "Email is not in a proper format"
            completion(title, message)
        case .couldNotDeleteFailedUserCreation:
             let message = "Failed to create user, but you cannot attempt with the same email at the moment. Please contact support to allow you to register with the same email if so desired"
            completion(title, message)
        case .noInternetConnection:
            let message = "No internet connection could be found"
            completion(title, message)
        default: fatalError("An error was used that has not been implemented into the alert handler. Change the error type or add it to the alert handler")
        }
    }
    
    private static func handleSceneError(error: ImproperSceneError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        let title = "Improper Scene Error"
        switch error {
        case .invalidAssignmentAtAllocator:
            let message = "An invalid assignment was given at the allocator"
            completion(title, message)
        case .invalidAssignmentAtPresenter:
            let message = "An invalid assignment was given at the presenter"
            completion(title, message)
        }
    }
}

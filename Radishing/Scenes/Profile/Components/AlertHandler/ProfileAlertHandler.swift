//
//  ProfileAlertHandler.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum ProfileAlertHandler: Alertable {
    
    //MARK: PARENT FUNCTION
    
    static func processError(_ error: Error, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        if let error = error as? AuthError {
            handleAuthError(error: error, completion: completion)
        } else if let error = error as? ImproperSceneError {
            handleImproperSceneError(error: error, completion: completion)
        }
    }
    
    //MARK: CHILD FUNCTIONS
    
    private static func handleAuthError(error: AuthError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        let title = "Authentication Error"
        switch error {
        case .signOutUnsuccessful:
            let message = "Signing out was unsuccessful"
            completion(title, message)
        case .unknownError:
            let message = "An unknown error has occurred"
            completion(title, message)
        default: fatalError("Either improper error given or error needs to be added to the alert handler")
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

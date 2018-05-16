//
//  ViewRecipeAlertHandler.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/3/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum ViewRecipeAlertHandler: Alertable {
    
    //MARK: PARENT FUNCTION
    
    static func processError(_ error: Error, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        if let error = error as? ViewRecipeError {
            handleViewRecipeError(error, completion: completion)
        } else if let error = error as? ImproperSceneError {
            handleImproperSceneError(error, completion: completion)
        }
    }
    
    //MARK: CHILD FUNCTIONS
    
    static private func handleViewRecipeError(_ error: ViewRecipeError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        let title = "View Recipe Error"
        switch error {
        case .couldNotDelete:
            let message = "Could not delete recipe"
            completion(title, message)
        }
    }
    
    static private func handleImproperSceneError(_ error: ImproperSceneError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
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

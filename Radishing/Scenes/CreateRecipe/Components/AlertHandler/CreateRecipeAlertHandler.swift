//
//  CreateRecipeAlertHandler.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/27/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum CreateRecipeAlertHandler: Alertable {
    
    //MARK: PARENT FUNCTION
    
    static func processError(_ error: Error, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        if let error = error as? CreateRecipeError {
            handleCreateRecipeError(error: error, completion: completion)
        } else if let error = error as? ImproperSceneError {
            handleImproperSceneError(error: error, completion: completion)
        }
    }
    
    //MARK: CHILD FUNCTIONS
    
    private static func handleCreateRecipeError(error: CreateRecipeError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        let title = "Recipe Creation Error"
        
        switch error {
        case .noImage:
            let message = "Need image to save the recipe"
            completion(title, message)
        case .noText:
            let message = "No text is found for the recipe"
            completion(title, message)
        case .textIsTooShort:
            let message = "The recipe needs to be at least 50 characters long"
            completion(title, message)
        case .imageUnableToConvertToData:
            let message = "The image can not be used due to incompatibilty"
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

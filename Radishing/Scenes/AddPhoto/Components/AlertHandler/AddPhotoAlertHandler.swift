//
//  AddPhotoAlertHandler.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum AddPhotoAlertHandler: Alertable {
    
    //MARK: PARENT FUNCTIONS
    
    static func processError(_ error: Error, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        if let error = error as? ImproperSceneError {
            handleImproperSceneError(error: error, completion: completion)
        }
    }
    
    //MARK: CHILD FUNCTIONS
    
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

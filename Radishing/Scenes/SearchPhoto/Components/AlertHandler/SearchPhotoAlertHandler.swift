//
//  SearchPhotoAlertHandler.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum SearchPhotoAlertHandler: Alertable {
    
    //MARK: PARENT FUNCTION
    
    static func processError(_ error: Error, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        
        if let error = error as? PhotoSearchError {
            handlePhotoSearchError(error: error, completion: completion)
        } else if let error = error as? ImproperSceneError {
            handleImproperSceneError(error: error, completion: completion)
        }
        
    }
    
    //MARK: CHILD FUNCTIONS
    
    private static func handlePhotoSearchError(error: PhotoSearchError, completion: @escaping (AlertTitle, AlertMessage) -> Void) {
        
        let title = "Photo Search Error"
        
        switch error {
        case .noMatches:
            let message = "No matches could be found. Search Again"
            completion(title, message)
        case .noPages:
            let message = "No matches could be found. Search Again"
            completion(title, message)
        case .noPhoto:
            let message = "A photo could not be properly retrieved"
            completion(title, message)
        case .noImageURLString:
            let message = "No URL for a retrieved image"
            completion(title, message)
        case .couldNotCreateURLFromString:
            let message = "Invalid URL for a retrieved image"
            completion(title, message)
        case .noPhotosDictionary:
            let message = "A photo dictionary to search for images could not be retrieved"
            completion(title, message)
        case .invalidStatus:
            let message = "You have retrieved an invalid status"
            completion(title, message)
        case .couldNotParseJSON:
            let message = "Image info retrieved could not be properly parsed"
            completion(title, message)
        case .unknownError:
            let message = " An unknown error has occured while searching"
            completion(title, message)
        case .improperStatusCode:
            let message = "Could not get an internet connect. Try again later"
            completion(title, message)
        case .noDataRetrieved:
            let message = "No data could be found for the retrieved image"
            completion(title, message)
        case .noInternetConnection:
            let message = "No internet connection could be found"
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

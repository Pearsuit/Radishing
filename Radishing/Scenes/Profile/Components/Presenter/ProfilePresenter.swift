//
//  ProfilePresenter.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

enum ProfilePresenter: PresenterSetupable {
    
    //MARK: Properties
    
    static weak var viewController: ViewControllable!
    static var alertHandler: Alertable.Type!
    
    //MARK: Parent Function
    
    static func fetchResults(_ results: Results) {
        switch results.assignment{
        case let authAssignment as AuthAssignment:
            handleAuthResults(assignment: authAssignment, error: results.error, model: results.model)
        case let offlineStorageAssignment as OfflineStorageAssignment:
            handleOfflineStorageResults(assignment: offlineStorageAssignment, error: results.error, model: results.model)
        case let databaseAssignment as DatabaseAssignment:
            handleDatabaseResults(assignment: databaseAssignment, error: results.error, model: results.model)
        case let improperAssignment as ImproperAssignment:
            handleImproperAssignment(assignment: improperAssignment, error: results.error!)
        default:
            handleInvalidAssignment()
        }
    }
    
    //MARK: Child Functions
    
    private static func handleAuthResults(assignment: AuthAssignment, error: Error?, model: ResultsModelable?) {
        switch assignment {
        case .fetchDisplayName:
            let displayName = model as! DisplayName
            CompilerCheckForViewModel(displayName)
        case .signOut:
            if let error = error {
                sendAlertDisplay(error: error)
            } else {
                let viewModel = SignOutSuccess(bool: true)
                CompilerCheckForViewModel(viewModel)
            }
        default: print("Error at presenter")
        }
    }
    
    private static func handleOfflineStorageResults(assignment: OfflineStorageAssignment, error: Error?, model: ResultsModelable?) {
        switch assignment {
        case .fetchData:
            handleFetchData(error: error, model: model)
        default: return
        }
    }
    
    private static func handleDatabaseResults(assignment: DatabaseAssignment, error: Error?, model: ResultsModelable?) {
        switch assignment {
        case .fetchRecipes:
            handleFetchRecipes(model: model)
        default: return
        }
    }
    
    private static func handleFetchData(error: Error?, model: ResultsModelable?) {
        if let error = error {
            sendAlertDisplay(error: error)
        } else if let photoData = model as? PhotoData, let data = photoData.data, let image = UIImage(data: data) {
            CompilerCheckForViewModel(image)
        }
    }
    
    private static func handleFetchRecipes(model: ResultsModelable?) {
        if let optionalRecipes = model as? OptionalRecipes  {
            CompilerCheckForViewModel(optionalRecipes)
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

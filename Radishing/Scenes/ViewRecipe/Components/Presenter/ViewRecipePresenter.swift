//
//  ViewRecipePresenter.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/3/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum ViewRecipePresenter: PresenterSetupable {
    
    //MARK: Properties
    
    static weak var viewController: ViewControllable!
    static var alertHandler: Alertable.Type!
    
    //MARK: Parent Function
    
    static func fetchResults(_ results: Results) {
        switch results.assignment {
        case let databaseAssignment as DatabaseAssignment:
            handleDatabaseInfo(assignment: databaseAssignment, error: results.error, model: results.model)
        case let improperAssignment as ImproperAssignment:
            handleImproperAssignment(assignment: improperAssignment, error: results.error!)
        default:
            handleInvalidAssignment()
        }
    }
    
    //MARK: Child Functions
    
    private static func handleDatabaseInfo(assignment: DatabaseAssignment, error: Error?, model: ResultsModelable?) {
        switch assignment {
        case .deleteRecipe:
            handleDeleteRecipeViewModel(error: error, model: model)
        default: return
        }
    }
    
    private static func handleDeleteRecipeViewModel(error: Error?, model: ResultsModelable?) {
        if let _ = error {
            let error = ViewRecipeError.couldNotDelete
            sendAlertDisplay(error: error)
        } else {
            let success = Success(bool: true)
            CompilerCheckForViewModel(success)
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

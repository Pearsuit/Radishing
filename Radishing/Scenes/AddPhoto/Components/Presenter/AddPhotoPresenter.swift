//
//  AddPhotoPresenter.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import Photos

enum AddPhotoPresenter: PresenterSetupable {
    
    //MARK: Properties
    
    static weak var viewController: ViewControllable!
    static var alertHandler: Alertable.Type!
    
    //MARK: Parent Function
    
    static func fetchResults(_ results: Results) {
        switch results.assignment {
        case let photoRetrievalAssignment as PhotoRetrievalAssignment:
            handlePhotoRetrievalInfo(assignment: photoRetrievalAssignment, error: results.error, model: results.model )
        case let improperAssignment as ImproperAssignment:
            handleImproperAssignment(assignment: improperAssignment, error: results.error!)
        default:
            handleInvalidAssignment()
        }
    }
    
    //MARK: Child Functions
    
    private static func handlePhotoRetrievalInfo(assignment: PhotoRetrievalAssignment, error: Error?, model: ResultsModelable?) {
        if let error = error {
            sendAlertDisplay(error: error)
        } else if let model = model as? ViewModelable {
            switch assignment {
            case .fetchPhotos, .fetchBetterQualityPhoto:
                CompilerCheckForViewModel(model)
            }
        } else {
            return
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

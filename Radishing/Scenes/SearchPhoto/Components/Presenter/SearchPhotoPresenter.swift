//
//  SearchPhotoPresenter.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import Photos

enum SearchPhotoPresenter: PresenterSetupable {
    
    static weak var viewController: ViewControllable!
    static var alertHandler: Alertable.Type!
    
    static func fetchResults(_ results: Results) {
        switch results.assignment {
        case let photoSearchAssignment as PhotoSearchAssignment:
            handlePhotoSearchResults(assignment: photoSearchAssignment, error: results.error, info: results.model)
        default: return
        }
    }
    
    private static func handlePhotoSearchResults(assignment: PhotoSearchAssignment, error: Error?, info: ResultsModelable?) {
        switch assignment {
        case .searchForPhotos:
            handleSearchForPhotos(error: error, info: info)
        }
    }
    
    private static func handleSearchForPhotos(error: Error?, info: ResultsModelable?) {
        if let error = error {
            sendAlertDisplay(error: error)
        } else if let imageData = info as? Data {
            guard let image = UIImage(data: imageData) else { return }
            CompilerCheckForViewModel(image)
        } else if let stopActivityIndicatorWithSync = info as? StopActivityIndicatorWithSync {
            CompilerCheckForViewModel(stopActivityIndicatorWithSync)
        }
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

//
//  SearchPhotoPhotoSearchProducer.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum SearchPhotoPhotoSearchProducer: ProducerSetupable {
    
    static var presenter: Presentable.Type!
    static var photoSearcher: PhotoSearchable!
    
    static func fetchWork(_ work: Work) {
        let assignment = work.assignment as! PhotoSearchAssignment
        photoSearcher = CurrentServices.photoSearcher
        presenter = work.presenter
        switch assignment {
        case .searchForPhotos:
            handleSearchForPhotos(info: work.model)
        }
    }
    
    static private func handleSearchForPhotos(info: RequestModelable?) {
        //Stops a search if the textField text is blank
        guard let text = info as? String, !text.isEmpty else {
            let info = StopActivityIndicatorWithSync(bool: false)
            let results = Results(assignment: PhotoSearchAssignment.searchForPhotos, error: nil, model: info)
            presenter.fetchResults(results)
            return
        }
        
        //Search for 20 photos
        let amount = 20
        var count = 0
        
        for _ in 1...amount {
            photoSearcher.searchByPhrase(phrase: text) { (data, error) in
                count += 1
                
                let results = Results(assignment: PhotoSearchAssignment.searchForPhotos, error: error, model: data)
                presenter.fetchResults(results)
                
                if count == amount {
                    let info = StopActivityIndicatorWithSync(bool: true)
                    let results = Results(assignment: PhotoSearchAssignment.searchForPhotos, error: nil, model: info)
                    presenter.fetchResults(results)
                }
            }
        }
    }
}

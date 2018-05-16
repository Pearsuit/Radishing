//
//  SearchPhotoAllocator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum SearchPhotoAllocator: AllocatorSetupable {
    
    static var presenter: Presentable.Type!
    
    static func fetchRequest(_ request: Request) {
        switch request.assignment {
        case let photoSearchAssignment as PhotoSearchAssignment:
            handlePhotoSearchProducerInitialization(assignment: photoSearchAssignment, model: request.model)
        default:
            let error = ImproperSceneError.invalidAssignmentAtAllocator
            let results = improperSceneErrorResult(error: error)
            presenter.fetchResults(results)
        }
    }
    
    private static func handlePhotoSearchProducerInitialization(assignment: PhotoSearchAssignment, model: RequestModelable?) {
        let work = Work(assignment: assignment, model: model, presenter: presenter)
        let producer: Producable.Type = SearchPhotoPhotoSearchProducer.self
        producer.fetchWork(work)
    }
    
    private static func improperSceneErrorResult(error: Error) -> Results {
        return Results(assignment: ImproperAssignment.catchError, error: error, model: nil)
    }
}

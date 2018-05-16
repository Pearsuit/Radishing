//
//  AddPhotoAllocator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum AddPhotoAllocator: AllocatorSetupable {
    
    //MARK: Properties
    
    static var presenter: Presentable.Type!
    
    //MARK: Parent Function
    
    static func fetchRequest(_ request: Request) {
        switch request.assignment {
        case let photoRetrievalAssignment as PhotoRetrievalAssignment:
            handlePhotoRetrievalProducerInitialization(assignment: photoRetrievalAssignment, model: request.model)
        default:
            let error = ImproperSceneError.invalidAssignmentAtAllocator
            let results = improperSceneErrorResult(error: error)
            presenter.fetchResults(results)
        }
    }
    
    //MARK: Child Functions
    
    private static func handlePhotoRetrievalProducerInitialization(assignment: PhotoRetrievalAssignment, model: RequestModelable?) {
        let work = Work(assignment: assignment, model: model, presenter: presenter)
        let producer: Producable.Type = AddPhotoPRProducer.self
        producer.fetchWork(work)
    }
    
    private static func improperSceneErrorResult(error: Error) -> Results {
        return Results(assignment: ImproperAssignment.catchError, error: error, model: nil)
    }
}

//
//  CreateRecipeAllocator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/27/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum CreateRecipeAllocator: AllocatorSetupable {
    
    //MARK: Properites
    
    static var presenter: Presentable.Type!
    
    //MARK: Parent Function
    
    static func fetchRequest(_ request: Request) {
        switch request.assignment {
        case let databaseAssignment as DatabaseAssignment:
            handleDatabaseProducerInitialization(assignment: databaseAssignment, model: request.model)
        default:
            let error = ImproperSceneError.invalidAssignmentAtAllocator
            let results = improperSceneErrorResult(error: error)
            presenter.fetchResults(results)
        }
    }
    
    //MARK: Child Functions
    
    private static func handleDatabaseProducerInitialization(assignment: DatabaseAssignment, model: RequestModelable?) {
        let work = Work(assignment: assignment, model: model, presenter: presenter)
        let producer: Producable.Type = CreateRecipeDatabaseProducer.self
        producer.fetchWork(work)
    }
    
    private static func improperSceneErrorResult(error: Error) -> Results {
        return Results(assignment: ImproperAssignment.catchError, error: error, model: nil)
    }
}

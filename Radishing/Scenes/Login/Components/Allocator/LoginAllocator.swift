//
//  LoginAllocator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum LoginAllocator: AllocatorSetupable {
    
    //MARK: Properties
    
    static var presenter: Presentable.Type!
    
    //MARK: Parent Function
    
    static func fetchRequest(_ request: Request) {
        switch request.assignment {
        case let authAssignment as AuthAssignment:
            handleAuthProducerInitialization(assignment: authAssignment, model: request.model)
        default:
            let error = ImproperSceneError.invalidAssignmentAtAllocator
            let results = improperSceneErrorResult(error: error)
            presenter.fetchResults(results)
        }
    }
    
    //MARK: Child Functions
    
    private static func handleAuthProducerInitialization(assignment: AuthAssignment, model: RequestModelable?) {
        let work = Work(assignment: assignment, model: model, presenter: presenter)
        let producer: Producable.Type = LoginAuthProducer.self
        producer.fetchWork(work)
    }
    
    private static func improperSceneErrorResult(error: Error) -> Results {
        return Results(assignment: ImproperAssignment.catchError, error: error, model: nil)
    }
}

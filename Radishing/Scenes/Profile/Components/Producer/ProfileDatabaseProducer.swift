//
//  ProfileDatabaseProducer.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/4/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum ProfileDatabaseProducer: DatabaseProducerSetupable {
    
    static var database: Databasable.Type!
    static var presenter: Presentable.Type!
    
    static func fetchWork(_ work: Work) {
        database = CurrentServices.database
        presenter = work.presenter
        let assignment = work.assignment as! DatabaseAssignment
        switch assignment {
        case .fetchRecipes:
            let userID = work.model as! String
            handleFetchRecipes(with: userID)
        default: return
        }
    }
    
    private static func handleFetchRecipes(with userID: String){
        database.read.fetchChildren(parentCollectionID: .recipes, parentDocumentID: userID, childCollectionID: "Posts", objectType: Recipe.self) { (recipes) in
            let info = OptionalRecipes(array: recipes)
            let results = Results(assignment: DatabaseAssignment.fetchRecipes, error: nil, model: info)
            presenter.fetchResults(results)
        }
    }
}

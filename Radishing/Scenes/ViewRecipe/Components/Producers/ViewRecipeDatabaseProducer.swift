//
//  ViewRecipeDatabaseProducer.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/3/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum ViewRecipeDatabaseProducer: DatabaseProducerSetupable {
    
    static var database: Databasable.Type!
    static var presenter: Presentable.Type!
    
    static func fetchWork(_ work: Work) {
        let assignment = work.assignment as! DatabaseAssignment
        presenter = work.presenter
        database = CurrentServices.database.self
        switch assignment {
        case .deleteRecipe:
            let recipeDeletionInfo = work.model as! RecipeDeletionInfo
            handleDeleteRecipe(with: recipeDeletionInfo)
        default: return
        }
    }
    
    private static func handleDeleteRecipe(with recipeDeletionInfo: RecipeDeletionInfo) {
        let recipe = recipeDeletionInfo.recipe
        let user = recipeDeletionInfo.user
        
        database.deleteChild(for: recipe, childCollectionID: "Posts", parentDocumentID: user.id!, hasPhoto: true) { error in
            let results = Results(assignment: DatabaseAssignment.deleteRecipe, error: error, model: nil)
            presenter.fetchResults(results)
        }
    }
}

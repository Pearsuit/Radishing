//
//  CreateRecipeDatabaseProducer.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/1/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import Photos

enum CreateRecipeDatabaseProducer: DatabaseProducerSetupable {
    
    static var database: Databasable.Type!
    static var presenter: Presentable.Type!
    
    static func fetchWork(_ work: Work) {
        let assignment = work.assignment as! DatabaseAssignment
        database = CurrentServices.database
        presenter = work.presenter
        switch assignment {
        case .validateRecipeForm:
            let recipeCheck = work.model as! RecipeCheck
            handleValidateRecipeForm(with: recipeCheck)
        case .createRecipe:
            let recipeForm = work.model as! RecipeForm
            handleCreateRecipe(with: recipeForm)
        default: return
        }
    }
    
    private static func handleValidateRecipeForm(with info: RecipeCheck) {
        do {
            let recipeForm = try createRecipeForm(with: info)
            let results = Results(assignment: DatabaseAssignment.validateRecipeForm, error: nil, model: recipeForm)
            presenter.fetchResults(results)
        } catch {
            let results = Results(assignment: DatabaseAssignment.validateRecipeForm, error: error, model: nil)
            presenter.fetchResults(results)
        }
    }
    
    private static func createRecipeForm(with recipeCheck: RecipeCheck) throws -> RecipeForm {
        guard let image = recipeCheck.image else { throw CreateRecipeError.noImage }
        guard let text = recipeCheck.text else { throw CreateRecipeError.noText }
        guard text.count >= 50 else { throw CreateRecipeError.textIsTooShort }
        guard let imageData = UIImageJPEGRepresentation(image, 0.3) else { throw CreateRecipeError.imageUnableToConvertToData }
        
        let recipeForm = RecipeForm(imageData: imageData, text: text)
        return recipeForm
    }
    
    private static func handleCreateRecipe(with recipeForm: RecipeForm) {
        
        let filename = NSUUID().uuidString
        let userID = CurrentServices.authenticator.loggedInUserID()!
        var recipe = Recipe(reference: .recipes, id: filename, imageURL: "", recipeText: recipeForm.text)
        
        CurrentServices.offlineStorage.uploadChildFolderData(parentFolder: "Recipes", childFolder: userID, filename: filename, data: recipeForm.imageData) { (storageURL) in
            
            guard let storageURL = storageURL else { return }
            recipe.imageURL = storageURL
            
            CurrentServices.database.create.customIDForChild(userID, childCollectionID: "Posts", childDocumentID: filename, for: recipe, completion: {
                let results = Results(assignment: DatabaseAssignment.createRecipe, error: nil, model: recipe)
                presenter.fetchResults(results)
            })
        }
    }
}

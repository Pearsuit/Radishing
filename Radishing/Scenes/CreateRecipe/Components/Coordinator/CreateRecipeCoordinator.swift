//
//  CreateRecipeCoordinator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/27/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

enum CreateRecipeCoordinator: CoordinatorSetupable {
    static weak var viewController: ViewControllable!
    
    static func transition(_ controller: Controller?, with data: [String : Any]?) {
        if controller == nil, let success = data?[CreateRecipeConstants.CoordinatorInfoKeys.recipe.string] as? Recipe {
            (viewController as! CreateRecipeViewController).reloadProfileRecipesDelegate.insertRecipe(success)
            (viewController as! UIViewController).dismiss(animated: true, completion: nil)
        }
    }
}

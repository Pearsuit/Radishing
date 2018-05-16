//
//  SearchPhotoCoordinator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

enum SearchPhotoCoordinator: CoordinatorSetupable {
    
    static weak var viewController: ViewControllable!
    
    static func transition(_ controller: Controller?, with data: [String : Any]?) {
        
        if let controller = controller {
            switch controller {
            case .createRecipe:
                let delegate = (viewController as! SearchPhotoViewController).reloadProfileRecipesDelegate!
                (viewController as! UIViewController).navigationController?.pushViewController(CreateRecipeViewController(delegate: delegate, recipeImage: data![SearchPhotoConstants.CoordinatorInfoKeys.image.string] as! UIImage), animated: true)
            default: return
            }
            
        } else {
            (viewController as! UIViewController).dismiss(animated: true, completion: nil)
        }
    }
}

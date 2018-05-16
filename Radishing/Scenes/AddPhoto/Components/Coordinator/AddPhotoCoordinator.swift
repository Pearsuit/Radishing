//
//  AddPhotoCoordinator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

enum AddPhotoCoordinator: CoordinatorSetupable {
    static weak var viewController: ViewControllable!
    
    static func transition(_ controller: Controller?, with data: [String : Any]?) {
        if let controller = controller {
            switch controller {
            case .createRecipe:
                let image = data![AddPhotoConstants.CoordinatorInfoKeys.image.string] as! UIImage
                let delegate = (viewController as! AddPhotoViewController).reloadProfileRecipesDelegate
                (viewController as! UIViewController).navigationController?.pushViewController(CreateRecipeViewController(delegate: delegate!, recipeImage: image), animated: true)
            default: return
            }
        } else if controller == nil {
            (viewController as! UIViewController).dismiss(animated: true, completion: nil)
        }
    }
}

//
//  ViewRecipeCoordinator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/3/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

enum ViewRecipeCoordinator: CoordinatorSetupable {
    
    static weak var viewController: ViewControllable!
    
    static func transition(_ controller: Controller?, with data: [String : Any]?) {
        if controller == nil, let success = data?[ViewRecipeConstants.CoordinatorInfoKeys.success.string] as? Bool, success == true {
            let indexPath = (viewController as! ViewRecipeViewController).indexPath!
            (viewController as! ViewRecipeViewController).delegate.deleteRecipe(at: indexPath)
            (viewController as! UIViewController).dismiss(animated: true, completion: nil)
        } else {
            (viewController as! UIViewController).dismiss(animated: true, completion: nil)
        }
    }
}

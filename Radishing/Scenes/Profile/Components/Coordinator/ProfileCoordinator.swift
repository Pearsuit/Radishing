//
//  ProfileCoordinator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

enum ProfileCoordinator: CoordinatorSetupable {
    
    static weak var viewController: ViewControllable!
    
    static func transition(_ controller: Controller?, with data: [String : Any]?) {
        if controller == nil {
            (viewController as! UIViewController).dismiss(animated: true, completion: nil)
        }
    }
}

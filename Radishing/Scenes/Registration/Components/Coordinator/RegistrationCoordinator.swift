//
//  RegistrationCoordinator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

enum RegistrationCoordinator: CoordinatorSetupable {
    
    static weak var viewController: ViewControllable!
    
    static func transition(_ controller: Controller?, with data: [String : Any]?) {
        if controller == nil {
            (viewController as! UIViewController).dismiss(animated: true, completion: nil)
        }
    }
}

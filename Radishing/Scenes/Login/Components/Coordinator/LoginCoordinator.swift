//
//  LoginCoordinator.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

enum LoginCoordinator: CoordinatorSetupable {
    
    static weak var viewController: ViewControllable!
    
    static func transition(_ controller: Controller?, with data: [String : Any]?) {
        
        guard let controller = controller else { return }
        
        switch controller {
        case .mainTab:
            let user = data![LoginConstants.CoordinatorInfoKeys.user.string] as! User
            let tabBarController = MainTabBarController(currentUser: user, animationDelegate: viewController as! WillAnimateSignDelegate)
            (viewController as! UIViewController).present(tabBarController, animated: true) {
                (viewController as! LoginViewController).newUser = nil
            }
        case .signup:
            let newController = RegistrationViewController()
            newController.fetchNewUserDelegate = viewController as! FetchNewUserDelegate
            (viewController as! UIViewController).present(newController, animated: true, completion: nil)
        default: return 
        }
    }
}

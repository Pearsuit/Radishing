//
//  Coordinatable.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

protocol CoordinatorSetupable: Coordinatable, StaticViewControllerInjectable {
}

protocol Coordinatable {
    
    static func transition(_ controller : Controller?, with data: [String :Any]?)
    
}

enum TransitionType {
    case present
    case dismiss
}

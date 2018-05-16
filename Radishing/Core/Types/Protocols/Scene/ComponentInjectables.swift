//
//  SceneReceivables.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol ViewControllerInjectable {
    
    var viewController: ViewControllable! { get set }
    
}

protocol StaticViewControllerInjectable {
    
    static var viewController: ViewControllable! { get set }
    
}

protocol AllocatorInjectable {
    
    var allocator: Allocatable.Type! { get set }
    
}

protocol StaticAllocatorInjectable {
    
    static var allocator: Allocatable.Type! { get set }
    
}

protocol PresenterInjectable {
    
    var presenter: Presentable.Type! { get set }
    
}

protocol StaticPresenterInjectable {
    
    static var presenter: Presentable.Type! { get set }
    
}

protocol CoordinatorInjectable {
    
    var coordinator: Coordinatable.Type! { get set }
    
}

protocol StaticCoordinatorInjectable {
    
    static var coordinator: Coordinatable.Type! { get set }
    
}

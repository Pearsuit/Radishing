//
//  ViewControllable.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol ViewControllerSetupable: ViewControllable, SceneFlowable {
}

@objc protocol ViewControllable {
    
    func fetchViewModel(_ viewModel: ViewModel)
    
}

protocol SceneFlowable: AllocatorInjectable, CoordinatorInjectable {
    
    func setupSceneFlow()
    
}

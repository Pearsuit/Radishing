//
//  BrowseViewController.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController, ViewControllerSetupable {
    
    var allocator: Allocatable.Type!
    
    var coordinator: Coordinatable.Type!
    
    var alertHandler: Alertable.Type?
    
    func fetchViewModel(_ viewModel: ViewModel) {
    }
    
    func setupSceneFlow() {
        //        let viewController = self
        //        let allocator = RegistrationAllocator.self
        //        let presenter = RegistrationPresenter.self
        //        let coordinator = RegistrationCoordinator.self
        //        let alertHandler = RegistrationAlertHandler.self
        //        viewController.allocator = allocator
        //        viewController.coordinator = coordinator
        //        viewController.alertHandler = alertHandler
        //        allocator.presenter = presenter
        //        presenter.viewController = viewController
        //        coordinator.viewController = viewController
    }
    
}


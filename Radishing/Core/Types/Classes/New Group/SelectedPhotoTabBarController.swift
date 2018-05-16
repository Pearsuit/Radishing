//
//  SelectedPhotoTabBarController.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit
import Photos

class SelectPhotoTabBarController: UITabBarController {
    
    var reloadProfileRecipesDelegate: UpdateProfileRecipesDelegate!
    
    init(delegate: UpdateProfileRecipesDelegate) {
        super.init(nibName: "SelectPhotoTabBarController", bundle: nil)
        self.reloadProfileRecipesDelegate = delegate
        self.delegate = self
        setupTabBarController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appLightGreen
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.barTintColor = .appPink
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        conformLayoutToDisplay(size: size)
    }
    
    func setupTabBarController() {
        let libraryPhotoVC = createController(viewController: AddPhotoViewController(delegate: reloadProfileRecipesDelegate), title: .Library)
        let searchOnlineVC = createController(viewController: SearchPhotoViewController(delegate: reloadProfileRecipesDelegate), title: .SearchOnline)
        
        viewControllers = [libraryPhotoVC, searchOnlineVC]
        tabBar.tintColor = .black
        selectedIndex = PHPhotoLibrary.authorizationStatus() == .authorized ? 0 : 1
        conformLayoutToDisplay(size: UIScreen.main.bounds.size)
    }
    
    private func createController(viewController: UIViewController, title: Tabs) -> UINavigationController {
        let vc = viewController
        vc.view.backgroundColor = .appLightGreen
        return createNavController(rootViewController: vc, title: title)
    }
    
    private func createNavController(rootViewController: UIViewController, title: Tabs) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.titleTextAttributes = [ .font: UIFont(name: AppFonts.fancy.string, size: 20)!, .foregroundColor: UIColor.appPink]
        navController.navigationBar.barTintColor = .appOffWhite
        navController.navigationBar.tintColor = .black
        navController.tabBarItem.title = title.string
        return navController
    }
    
    private enum Tabs: String {
        case Library
        case SearchOnline = "Search Online"
    }
}

extension SelectPhotoTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        
        if index == 0 {
            var bool = false
            checkAuthorization { bool = $0 }
            return bool
        } else {
            return true
        }
    }
    
    private func checkAuthorization(completion: @escaping (Bool) -> Void) {
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            PHPhotoLibrary.requestAuthorization { [unowned self] (status) in
                if status == .authorized {
                    completion(true)
                } else {
                    presentAlert(title: "Previously Denied Access", alertMessage: "To allow us access to your photos, please change your authorization status in the main Settings app ", UIViewController: self, completion: nil)
                    completion(false)
                }
            }
        } else {
            completion(true)
        }
    }
}

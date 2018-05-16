//
//  MainTabBarController.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/24/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit
import Photos

protocol WillAnimateSignDelegate {
    var willAnimateSign: Bool { get set }
}

class MainTabBarController: UITabBarController {
    
    private var currentUser: User?
    
    var animationDelegate: WillAnimateSignDelegate?
    
    init(currentUser: User?, animationDelegate: WillAnimateSignDelegate) {
        super.init(nibName: "MainTabBarController", bundle: nil)
        
        self.currentUser = currentUser
        self.animationDelegate = animationDelegate
        self.animationDelegate?.willAnimateSign = true
        setupTabBarController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appOffWhite
        delegate = self
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.barTintColor = .appBluishGray
    }
    
    func setupTabBarController() {
        let addPhotoVC = createController(viewController: UIViewController(), icon: .AddPhotoImage)
        let profileVC = createController(viewController: ProfileViewController(currentUser: currentUser), icon: .ProfileImage)
        
        viewControllers = [profileVC, addPhotoVC]
        tabBar.tintColor = .black
        
        for item in tabBar.items! {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    private func createController(viewController: UIViewController, icon: Tabs) -> UINavigationController {
        let vc = viewController
        vc.view.backgroundColor = .appOffWhite
        return createNavController(rootViewController: vc, icon: icon)
    }
    
    private func createNavController(rootViewController: UIViewController, icon: Tabs) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.titleTextAttributes = [ .font: UIFont(name: AppFonts.fancy.string, size: 20)!, .foregroundColor: UIColor.appPink]
        navController.navigationBar.barTintColor = .appOffWhite
        navController.tabBarItem.image = UIImage(named: icon.string)
        return navController
    }
    
    private enum Tabs: String {
        case PhotoFeedImage
        case BrowseImage
        case AddPhotoImage
        case LikesImage
        case ProfileImage
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        
        if index == 1 {
            self.present(SelectPhotoTabBarController(delegate: (self.viewControllers![0] as! UINavigationController).viewControllers[0] as! UpdateProfileRecipesDelegate), animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
}

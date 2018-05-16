//
//  AppDelegate.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //MARK: APP LIFECYCLE

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        CurrentServices.database.configure()
        
        window = UIWindow()
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
        
        // This signs out a user if the app was deleted and reinstalled since sign in to Firebase can still persist after logging out, according to some testing.
        
        checkIfAUserIsLoggedInUponReinstallation()
        
        //Checks if there is a user logged into the app
        
        checkIfAUserIsCurrentlyLoggedIn()
        
        return true
    }
    
    //MARK: CHILD FUNCTIONS
    
    private func checkIfAUserIsLoggedInUponReinstallation() {
        if CurrentServices.localStorage.retrieve(for: "installed") == nil {
            CurrentServices.authenticator.signOut { (error) in
                if let _ = error {
                    CurrentServices.localStorage.delete(for: "user")
                }
            }
            CurrentServices.localStorage.save(value: true, key: "installed") {
            }
        }
    }
    
    private func checkIfAUserIsCurrentlyLoggedIn() {
        
        if let userID = CurrentServices.authenticator.loggedInUserID() {
            
            guard let userInfo = CurrentServices.localStorage.retrieve(for: "user") as? [String : Any ] else {
                CurrentServices.authenticator.signOut { (error) in
                    if let _ = error {
                        CurrentServices.localStorage.delete(for: "user")
                    }
                }
                return
            }
            
            var userJSON = userInfo
            userJSON["id"] = userID
            userJSON["reference"] = DatabaseReference.users.string
            
            do {
                let userData = try JSONSerialization.data(withJSONObject: userJSON, options: [])
                let decodeObject = try JSONDecoder().decode(User.self, from: userData)
                window?.rootViewController?.present(MainTabBarController(currentUser: decodeObject, animationDelegate: window!.rootViewController as! WillAnimateSignDelegate), animated: true, completion: nil)
            } catch {
                CurrentServices.authenticator.signOut { (error) in
                    if let _ = error {
                        CurrentServices.localStorage.delete(for: "user")
                    }
                }
            }
        }
    }
}


//
//  FIRNotificationWorker.swift
//  Argo
//
//  Created by Nathaniel Dillinger on 4/12/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit
import UserNotifications

class FIRNotificationService: NSObject, Notifiable {
    
    private override init () {}
    static let shared = FIRNotificationService()
    private let center = UNUserNotificationCenter.current()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        center.requestAuthorization(options: options) { (granted, error) in
            guard error == nil else { return }
            guard granted == true else { return }
            DispatchQueue.main.async {
                self.configure()
            }
        }
    }
    
    func configure() {
        center.delegate = self
        let application = UIApplication.shared
        application.registerForRemoteNotifications()
    }
    
}

extension FIRNotificationService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("un did recieve")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("un will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
        
    }
    
}

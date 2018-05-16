//
//  ErrorAlert.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/23/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

func presentAlert(title: String, alertMessage: String, UIViewController: UIViewController, completion: (() -> ())?) {
    
    let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .cancel)
    
    alert.addAction(okAction)
    
    UIViewController.present(alert, animated: true) {
        
        if let completion = completion {
            
            completion()
            
        }
    }
}

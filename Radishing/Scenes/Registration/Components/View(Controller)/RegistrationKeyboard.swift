//
//  RegistrationKeyboard.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/3/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension RegistrationViewController: UITextFieldDelegate {
    
    // Keyboard Functions:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        currentTextField = nil
        
        return true
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        if (currentDevice == .iPhoneXLandscape || currentDevice == .iPhoneLandscape) && currentTextField == .email  {
            
            view.frame.origin.y = 0
            
        } else {
            view.frame.origin.y = -(getKeyboardHeight(notification) / 2.3)
        }
        
        
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        
        view.frame.origin.y = 0
        
    }
    
    func getKeyboardHeight(_ notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyBoardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyBoardSize.cgRectValue.height
        
    }
    
    // Keyboard Notification Function:
    
    func subscribeToKeyboardNotifications(_ subscribe: Bool) {
        
        if subscribe {
            
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
            
        } else {
            
            NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
            NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
            
        }
        
    }
    
    
}

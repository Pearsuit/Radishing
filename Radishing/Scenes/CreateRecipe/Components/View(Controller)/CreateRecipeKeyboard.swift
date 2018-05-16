//
//  CreateRecipeKeyboard.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/4/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension CreateRecipeViewController: UITextViewDelegate {
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        view.frame.origin.y = 0
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

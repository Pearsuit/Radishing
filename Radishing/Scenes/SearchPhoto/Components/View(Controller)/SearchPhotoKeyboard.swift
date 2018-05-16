//
//  SearchPhotoKeyboard.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension SearchPhotoViewController: UITextFieldDelegate {
    // Keyboard Functions:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

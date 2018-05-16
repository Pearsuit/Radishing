//
//  RegistrationForm.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/5/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

struct RegistrationForm: RequestModelable, ResultsModelable, ViewModelable {
    
    let email: String
    
    let username: String
    
    let password: String
    
    let image: UIImage?
    
}

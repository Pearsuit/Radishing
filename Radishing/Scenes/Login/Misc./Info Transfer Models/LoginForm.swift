//
//  LoginForm.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/5/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

struct LoginForm: RequestModelable, ResultsModelable, ViewModelable {
    
    let email: String
    
    let password: String
    
}

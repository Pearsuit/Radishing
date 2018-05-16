//
//  RegistrationCheck.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/11/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

struct RegistrationCheck: RequestModelable {
    
    let email: String?
    
    let username: String?
    
    let password: String?
    
    let reEnterPassword: String?
    
}

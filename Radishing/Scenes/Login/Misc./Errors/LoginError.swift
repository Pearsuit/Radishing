//
//  LoginInError.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/27/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case emptyEmailTextField
    case emptyPasswordTextField
    case emailIsNotRegistered
    case noData
}

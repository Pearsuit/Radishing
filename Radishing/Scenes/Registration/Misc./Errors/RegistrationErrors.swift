//
//  RegistrationErrors.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/21/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum RegistrationError: Error {
    case incompleteForm
    case mismatchedPasswords
    case invalidEmail
    case emailTaken
    case photoCouldNotBeSet
    case passwordLength
    case usernameLength
    case noUserData
}

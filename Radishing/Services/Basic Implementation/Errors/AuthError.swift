//
//  AuthError.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/22/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum AuthError: Error {
    case phoneLoginUnsuccessful
    case emailLoginUnsuccessful
    case signOutUnsuccessful
    case createPhoneAuthUnsuccessful
    case createEmailAuthUnsuccessful
    case checkIfEmailIsTakenSearchError
    case emailAlreadyInUse
    case displayNameCreationError
    case emailIsNotRegistered
    case emailIsNotProperlyFormatted
    case unknownError
    case couldNotDeleteFailedUserCreation
    case noInternetConnection
}

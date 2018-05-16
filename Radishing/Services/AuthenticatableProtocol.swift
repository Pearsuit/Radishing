//
//  AuthenticatableProtocol.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/12/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol Authenticatable: Servicable {
    
    static func createPhoneAuth(completion: @escaping () -> Void) throws
    
    static func phoneLogin(completion: @escaping () -> Void) throws
    
    static func createEmailAuth(email: String, username: String, password: String, data: Data?, completion: @escaping (AuthError?, User?) -> Void)
    
    static func emailLogin(email: String, password: String, completion: @escaping (Error?, User?) -> Void)
    
    static func signOut(completion: @escaping (Error?) -> Void)
    
    static func fetchDisplayName(completion: @escaping (String) -> Void )
    
    static func loggedInUserID() -> String?
    
}

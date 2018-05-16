//
//  FirestoreReference.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/9/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

extension RawRepresentable where RawValue == String {
    var string: String {
        return rawValue
    }
}

enum DatabaseReference: String, Codable {
    case users
    case recipes
}

enum ExcludedKeys: String {
    case id
    case reference
}

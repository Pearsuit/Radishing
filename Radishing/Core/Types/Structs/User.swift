//
//  User.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/10/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

struct User: DatabaseWorkerable, ResultsModelable ,ViewModelable {
    var reference: DatabaseReference
    
    var id: String?
    
    var photoURL: StorageURL?
    
}

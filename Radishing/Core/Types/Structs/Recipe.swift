//
//  Recipe.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/1/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation


struct Recipe: DatabaseWorkerable, ResultsModelable, ViewModelable {
    var reference: DatabaseReference
    
    var id: String?
    
    var imageURL: StorageURL
    
    var recipeText: String
    
}

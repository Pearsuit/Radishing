//
//  RecipeForm.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/5/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

struct RecipeForm: RequestModelable, ResultsModelable, ViewModelable {
    
    let imageData: Data
    
    let text: String
    
}

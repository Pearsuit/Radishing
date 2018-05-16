//
//  Recipes.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/10/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

struct Recipes: ViewModelable {
    let array: [Recipe]
}

struct OptionalRecipes: ResultsModelable, ViewModelable {
    let array: [Recipe]?
}

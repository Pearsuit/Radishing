//
//  RecipeDeletionInfo.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/12/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

struct RecipeDeletionInfo: RequestModelable {
    let user: User
    let recipe: Recipe
}

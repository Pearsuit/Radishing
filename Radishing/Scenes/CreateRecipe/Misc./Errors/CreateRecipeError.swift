//
//  CreateRecipeError.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/1/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum CreateRecipeError: Error {
    
    case noImage
    case noText
    case textIsTooShort
    case imageUnableToConvertToData
}

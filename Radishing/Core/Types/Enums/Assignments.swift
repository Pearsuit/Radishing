//
//  Assignments.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/3/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol Assignable { }

enum DatabaseAssignment: Assignable {
    case createRecipe
    case deleteRecipe
    case fetchRecipes
    case validateRecipeForm
}

enum AuthAssignment: Assignable {
    case emailSignUp
    case emailSignIn
    case fetchDisplayName
    case signOut
    case validateSignUpForm
    case checkForCompleteSignUpForm
    case validateSignInForm
}

enum OfflineStorageAssignment: Assignable {
    case uploadData
    case fetchData
}

enum PhotoRetrievalAssignment: Assignable {
    case fetchPhotos
    case fetchBetterQualityPhoto
}

enum ImproperAssignment: Assignable {
    case catchError
}

enum PhotoSearchAssignment: Assignable {
    case searchForPhotos
}

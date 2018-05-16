//
//  PhotoSearchError.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/8/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum PhotoSearchError: Error {
    case noMatches
    case noPages
    case noPhoto
    case noImageURLString
    case couldNotCreateURLFromString
    case noPhotosDictionary
    case invalidStatus
    case couldNotParseJSON
    case unknownError
    case improperStatusCode
    case noDataRetrieved
    case noInternetConnection
}

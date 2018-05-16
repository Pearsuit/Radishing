//
//  OfflineStorageError.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum OfflineStorageError: Error {
    case invalidURLCreation
    case retrievalError
    case noDataFoundError
    case improperStatusCode
}

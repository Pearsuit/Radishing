//
//  PhotoFetch.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/12/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

struct PhotoFetch: RequestModelable {
    let storageURL: StorageURL
}

struct PhotoData: ResultsModelable {
    let data: Data?
}

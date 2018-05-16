//
//  OfflineStoragable.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/12/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol OfflineStoragable: Servicable {
    
    static func uploadData(folder: String, filename: String, data: Data, completion: @escaping (StorageURL?) -> Void)
    
    static func uploadChildFolderData(parentFolder: String, childFolder: String, filename: String, data: Data, completion: @escaping (StorageURL?) -> Void)
    
    static func fetchData(url: StorageURL, completion: @escaping (Data?, Error?) -> Void)
    
    static func deleteChildFolderData(parentFolder: String, childFolder: String, filename: String, completion: @escaping (Error?) -> Void)
    
}

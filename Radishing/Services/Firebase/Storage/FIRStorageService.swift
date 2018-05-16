//
//  FIRStorageWorker.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/12/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import FirebaseStorage

enum FIRStorageService: OfflineStoragable {
    
    static func uploadData(folder: String, filename: String, data: Data, completion: @escaping (StorageURL?) -> Void) {
        
        Storage.storage().reference().child(folder).child(filename).putData(data, metadata: nil) { (metadata, error) in
            guard error == nil else { completion(nil); return }
            
            guard let dataURL = metadata?.downloadURL()?.absoluteString else { completion(nil); return }
            
            completion(dataURL)
            
        }
    }
    
    static func uploadChildFolderData(parentFolder: String, childFolder: String, filename: String, data: Data, completion: @escaping (StorageURL?) -> Void) {
        
        Storage.storage().reference().child(parentFolder).child(childFolder).child(filename).putData(data, metadata: nil) { (metadata, error) in
            guard error == nil else { completion(nil); return }
            
            guard let dataURL = metadata?.downloadURL()?.absoluteString else { completion(nil); return }
            
            completion(dataURL)
            
        }
        
        
    }
    
    static func deleteChildFolderData(parentFolder: String, childFolder: String, filename: String, completion: @escaping (Error?) -> Void) {
        
        Storage.storage().reference().child(parentFolder).child(childFolder).child(filename).delete { (error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
    }
    
    static func fetchData(url: StorageURL, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let storageUrl = URL(string: url) else {
            let error = OfflineStorageError.invalidURLCreation
            completion(nil, error)
            return
        }
        
        URLSession.shared.dataTask(with: storageUrl) { (data, response, error) in
            guard error == nil else {
                let error = OfflineStorageError.retrievalError
                completion(nil, error)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                
                let error = OfflineStorageError.improperStatusCode
                completion(nil, error)
                return
                
            }
            
            if storageUrl.absoluteString != url {
                completion(nil, nil)
                return
            }
            
            guard let data = data else {
                let error = OfflineStorageError.noDataFoundError
                completion(nil, error)
                return
            }
            
            completion(data, nil)
            
        }.resume()
    }
    
}

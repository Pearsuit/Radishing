//
//  HelperFunctions.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/2/2018.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension FlickrAPI {
    
    //MARK: URL CREATOR
    
    func flickrURLFromParameters(_ parameters: [String:AnyObject]) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.Flickr.APIScheme
        components.host = Constants.Flickr.APIHost
        components.path = Constants.Flickr.APIPath
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    //MARK: DATA RETRIEVER
    
    func retrieveDataSecurely(data: Data?, response: URLResponse?, error: Error?, domain: String, completion: @escaping (_ imageData: Data?, _ error: Error?) -> Void) -> Data? {
        
        guard (error == nil) else {
            print("An error has occurred while looking for photos: \(error!.localizedDescription)")
            
            if error!.localizedDescription.contains("connection") {
                completion(nil, PhotoSearchError.noInternetConnection)
            } else {
                completion(nil, PhotoSearchError.unknownError)
            }
            return nil
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
            completion(nil, PhotoSearchError.improperStatusCode)
            return nil
        }
        
        guard let data = data else {
            completion(nil, PhotoSearchError.noDataRetrieved)
            return nil
        }
        
        return data
        
    }
    
}

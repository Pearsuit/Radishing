//
//  JSONHandlers.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/2/17.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension FlickrAPI {
    
    //MARK: PHOTO DICTIONARY RETRIEVER
    
    func retrievePhotosDictionary(data: NSData, completion: (_ imageData: Data?, _ error: Error?) -> Void) -> [String: AnyObject]?{
        
        var parsedResult: [String: AnyObject]!
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! [String: AnyObject]
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completion(nil, PhotoSearchError.couldNotParseJSON)
        }
        
        guard let stat = parsedResult[Constants.FlickrResponseKeys.Status] as? String, stat == Constants.FlickrResponseValues.OKStatus else {
            completion(nil, PhotoSearchError.invalidStatus)
            return nil
        }
        
        /* GUARD: Is "photos" key in our result? */
        guard let photosDictionary = parsedResult[Constants.FlickrResponseKeys.Photos] as? [String:AnyObject] else {
            completion(nil, PhotoSearchError.noPhotosDictionary)
            return nil
        }
        
        return photosDictionary
    }
    
    //MARK: RANDOM PAGE NUMBER RETRIEVER
    
    func retrievePageNumber(photosDictionary: [String: AnyObject], completion: (_ imageData: Data?, _ error: Error?) -> Void) -> Int? {
        
        guard let totalPages = photosDictionary[Constants.FlickrResponseKeys.Pages] as? Int else {
            completion(nil, PhotoSearchError.noPages)
            return nil
        }
        
        // pick a random page!
        let pageLimit = min(totalPages, 40)
        let randomPage = Int(arc4random_uniform(UInt32(pageLimit))) + 1
        
        return randomPage
    }
    
    //MARK: RANDOM PHOTO RETRIEVER
    
    func retrievePhotoData(photosDictionary: [String: AnyObject], completion: (_ imageData: Data?, _ error: Error?) -> Void){
        
        var myImageData: Data?
        
        guard let photosArray = photosDictionary[Constants.FlickrResponseKeys.Photo] as? [[String: AnyObject]] else {
            completion(nil, PhotoSearchError.noPhoto)
            return
        }
        
        if photosArray.count == 0 {
            completion(nil, PhotoSearchError.noMatches)
            return
        } else {
            let randomPhotoIndex = Int(arc4random_uniform(UInt32(photosArray.count)))
            let photoDictionary = photosArray[randomPhotoIndex] as [String: AnyObject]
            
            /* GUARD: Does our photo have a key for 'url_m'? */
            guard let imageUrlString = photoDictionary[Constants.FlickrResponseKeys.MediumURL] as? String else {
                completion(nil, PhotoSearchError.noImageURLString)
                return
            }
            
            // if an image exists at the url, set the image and title
            let imageURL = URL(string: imageUrlString)
            if let imageData = try? Data(contentsOf: imageURL!) {
                
                myImageData = imageData
                print(myImageData)
                completion(myImageData, nil)
                
            } else {
                completion(nil, PhotoSearchError.couldNotCreateURLFromString)
            }
        }
    }
}

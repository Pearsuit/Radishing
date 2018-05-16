//
//  FlickrAPI.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 05/02/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//
import UIKit

class FlickrAPI: NSObject, PhotoSearchable {
    
    private override init () {}
    static let shared = FlickrAPI()
    
    //MARK: PARENT SEARCH FUNCTION
    
    //The parent search function to download images
    
    func searchByPhrase(phrase: String, completion: @escaping (_ imageData: Data?, _ error: Error?) -> Void) {
        
        let methodParameters = [
            Constants.FlickrParameterKeys.Method: Constants.FlickrParameterValues.SearchMethod,
            Constants.FlickrParameterKeys.APIKey: APIKeys.flickr.string,
            Constants.FlickrParameterKeys.Text: phrase,
            Constants.FlickrParameterKeys.SafeSearch: Constants.FlickrParameterValues.UseSafeSearch,
            Constants.FlickrParameterKeys.Extras: Constants.FlickrParameterValues.MediumURL,
            Constants.FlickrParameterKeys.Format: Constants.FlickrParameterValues.ResponseFormat,
            Constants.FlickrParameterKeys.NoJSONCallback: Constants.FlickrParameterValues.DisableJSONCallback
        ]
        displayImageFromFlickrBySearch(methodParameters: methodParameters as [String:AnyObject], completion: completion)
        
        
    }
    
    //MARK: CHILD SEARCH FUNCTIONS
    
    // Child search function that will generate a random page from the coordinate search function
    private func displayImageFromFlickrBySearch(methodParameters: [String: AnyObject], completion: @escaping (_ imageData: Data?, _ error: Error?) -> Void){
        
        print("random page search started")
        
        let session = URLSession.shared
        let request = URLRequest(url: flickrURLFromParameters(methodParameters))
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            
            guard let data = self.retrieveDataSecurely(data: data, response: response, error: error, domain: "getRandomPage", completion: completion) else {
                return
            }
            
            guard let photosDictionary = self.retrievePhotosDictionary(data: data as NSData, completion: completion) else {
                return
            }
            
            guard let randomPage = self.retrievePageNumber(photosDictionary: photosDictionary, completion: completion) else {
                return
            }
            
            self.displayImageFromFlickrBySearch(methodParameters, withPageNumber: randomPage, completion: completion)
        }
        
        task.resume()
        
    }
    
    //Child search function of the random page function that will retrieve a random photo from the random page given

    private func displayImageFromFlickrBySearch(_ methodParameters: [String: AnyObject], withPageNumber: Int, completion: @escaping (_ imageData: Data?, _ error: Error?) -> Void) {
        
        print("photo search started")
        
        var methodParametersWithPageNumber = methodParameters
        methodParametersWithPageNumber[Constants.FlickrParameterKeys.Page] = withPageNumber as AnyObject?
        let session = URLSession.shared
        let request = URLRequest(url: flickrURLFromParameters(methodParameters))
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let data = self.retrieveDataSecurely(data: data, response: response, error: error, domain: "getRandomPhoto", completion: completion) else {
                return
            }
            
            guard let photosDictionary = self.retrievePhotosDictionary(data: data as NSData, completion: completion) else {
                return
            }
            
            self.retrievePhotoData(photosDictionary: photosDictionary, completion: completion)
            
        }
        
        task.resume()
    }
    
}

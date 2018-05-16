//
//  PhotoRetrievalService.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import Photos

enum PhotoRetrievalService: PhotoRetrievable {
    
    static func fetchLowQualityPhotos(completion: @escaping ([UIImage], [PHAsset]) -> Void) {
        
        var images = [UIImage]()
        var assets = [PHAsset]()
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 20
        
        let sortDescriptor = NSSortDescriptor(key: PhotoSortingKeys.creationDate.string, ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        
        let photos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        DispatchQueue.global(qos: .background).async {
            
            photos.enumerateObjects { (asset, count, stop) in
                
                let imageManager = PHImageManager.default()
                
                let imageSize = CGSize(width: 250, height: 250)
                
                let imageRequestOptions = PHImageRequestOptions()
                imageRequestOptions.isSynchronous = true
                
                imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: imageRequestOptions, resultHandler: { (image, info) in
                    
                    if let image = image {
                        images.append(image)
                        assets.append(asset)
                    }
                    
                    if count == photos.count - 1 {
                        completion(images, assets)
                    }
                    
                })
            }
            
        }
        
    }
    
    static func fetchBetterQualitySinglePhoto(asset: PHAsset, completion: @escaping (UIImage) -> Void) {
        
        let imageManager = PHImageManager.default()
        let imageSize = CGSize(width: 700, height: 700)
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .default, options: nil) { (image, info) in
            
            guard let image = image else { return }
            
            completion(image)
            
        }
        
    }
    
}


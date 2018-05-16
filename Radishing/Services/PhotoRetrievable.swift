//
//  PhotoRetrievable.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import Photos

protocol PhotoRetrievable {
    
    static func fetchLowQualityPhotos(completion: @escaping ([UIImage], [PHAsset]) -> Void)
    
    static func fetchBetterQualitySinglePhoto(asset: PHAsset, completion: @escaping (UIImage) -> Void)
    
}

//
//  PhotosAndAssets.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/11/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import Photos

struct PhotosAndAssets: ResultsModelable, ViewModelable {
    
    let photos: [UIImage]
    
    let assets: [PHAsset]
    
}

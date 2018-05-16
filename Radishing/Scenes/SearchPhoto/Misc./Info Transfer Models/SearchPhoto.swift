//
//  SearchPhoto.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Photos

typealias SearchImage = UIImage

extension UIImage: ResultsModelable, ViewModelable {}

extension PHAsset: RequestModelable {}

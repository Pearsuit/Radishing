//
//  AddPhotoHeaderLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension AddPhotoHeader: ResponsiveLayoutable {
    func conformLayoutToDisplay(size: CGSize) {
        photoImageView.isHidden = size.height == 1 ? true : false
        photoImageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.width)
    }
}


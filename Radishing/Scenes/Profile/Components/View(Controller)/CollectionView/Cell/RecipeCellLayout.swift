//
//  RecipeCellLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/2/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension RecipeCell: ResponsiveLayoutable {
    func conformLayoutToDisplay(size: CGSize) {
        photoImageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        activityIndicator.frame = CGRect(x: size.width / 4 , y: size.width / 4 , width: size.width / 2 , height: size.width / 2)
    }
}

//
//  SearchPhotoCellLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension SearchPhotoCell: ResponsiveLayoutable {
    func conformLayoutToDisplay(size: CGSize) {
        imageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
}

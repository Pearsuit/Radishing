//
//  SelectedPhotoTabBarLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/9/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension SelectPhotoTabBarController: ResponsiveLayoutable {

    func conformLayoutToDisplay(size: CGSize) {
        
        if size.height / size.width > 1 {
            
            if UIDevice().userInterfaceIdiom == .pad {
                for item in tabBar.items! {
                    item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
                }
            } else {
                for item in tabBar.items! {
                    item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
                }
            }
            
        } else {
            for item in tabBar.items! {
                item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
            }
        }
    }
}

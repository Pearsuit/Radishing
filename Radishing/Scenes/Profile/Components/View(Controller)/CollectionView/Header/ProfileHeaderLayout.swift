//
//  ProfileHeaderLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension ProfileHeader: ResponsiveLayoutable {
    func conformLayoutToDisplay(size: CGSize) {
        
        let newWidth = size.width
        let newHeight = size.height
        
        if (newWidth / 3) > newHeight { // Landscape
            
            profileImageView.isHidden = true
            recipesLabel.isHidden = true
            recipesCountLabel.isHidden = true
            
            buttonContainerView.frame = CGRect(x: 0, y: 0,
                                               width: newWidth, height: newHeight)
            
            gridButton.frame = CGRect(x: 0, y: 0, width: newWidth / 2,
                                      height: newHeight)
            
            listButton.frame = CGRect(x: newWidth / 2, y: 0,
                                      width: newWidth / 2, height: newHeight)
            
        } else { // Portrait
            
            profileImageView.isHidden = false
            recipesLabel.isHidden = false
            recipesCountLabel.isHidden = false
            
            buttonContainerView.frame = CGRect(x: 0, y: newHeight - (newHeight / 5 ),
                                               width: newWidth, height: newHeight / 5 )
            
            gridButton.frame = CGRect(x: 0, y: 0, width: newWidth / 2,
                                      height: newHeight / 5)
            
            listButton.frame = CGRect(x: newWidth / 2, y: 0,
                                      width: newWidth / 2, height: newHeight / 5)
            
            
            profileImageView.frame = CGRect(x: newWidth / 2 - newWidth / 10, y: newHeight / 20,
                                            width: newWidth / 5, height: newWidth / 5)
            
            profileImageView.layer.cornerRadius = newWidth / 10
            
            let imageHeight = profileImageView.frame.height
            
            recipesLabel.frame = CGRect(x: newWidth / 2 - imageHeight / 2 , y: newHeight / 20 + imageHeight,
                                        width: imageHeight, height: newHeight / 9)
            
            recipesLabel.font = recipesLabel.font.withSize(newHeight / 10)
            
            let recipesLabelHeight = recipesLabel.frame.height
            
            recipesCountLabel.frame = CGRect(x: newWidth / 2 - imageHeight, y: newHeight / 15 + imageHeight + recipesLabelHeight,
                                             width: imageHeight * 2, height: recipesLabelHeight * 1.5)
            
            recipesCountLabel.font = recipesCountLabel.font.withSize(newHeight /  6.5 )
            
        }
        
    }
}

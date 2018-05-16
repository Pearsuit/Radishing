//
//  ProfileLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension ProfileViewController: ResponsiveLayoutable {
    
    func conformLayoutToDisplay(size: CGSize) {
        
        var (newWidth, newHeight) = (size.width, size.height)
        
        //iPad seems to have the new UIScreen dimensions before the process starts, so it does not need the swap out the dimensions
        
        if hasAppearedAlready && UIDevice().userInterfaceIdiom != .pad {
            (newWidth, newHeight) = (size.height, size.width)
        }
        
        if (newWidth / newHeight) > 1 { //Landscape
            
            profileLandscapeView.isHidden = false
            
            if (newWidth / newHeight) > 2.1 { //iPhone X
                
                currentDevice = .iPhoneXLandscape
                
                let navBarHeight: CGFloat = 32
                let tabBarHeight: CGFloat = 53
                let sidePadding: CGFloat = 64
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth - sidePadding * 2
                
                containerView.frame = CGRect(x: 64, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createPhoneXLandscapeDisplay(newHeight: screenHeight, newWidth: screenWidth)
                
            } else if UIDevice().userInterfaceIdiom == .pad { //iPad
                
                currentDevice = .iPadLandscape
                
                let navBarHeight: CGFloat = 32
                let tabBarHeight: CGFloat = 32
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createPadLandscapeDisplay(newHeight: screenHeight, newWidth: screenWidth)
                
            } else {
                
                currentDevice = .iPhoneLandscape
                
                let navBarHeight: CGFloat =  newWidth > 700 ? 44 : 32
                let tabBarHeight: CGFloat = newWidth > 700 ? 44 : 32
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createPhoneLandscapeDisplay(newHeight: screenHeight, newWidth: screenWidth)
                
            }
        } else {
            
            profileLandscapeView.isHidden = true
            
            if (newHeight / newWidth) > 2 {
                
                currentDevice = .iPhoneXPortrait
                
                let navBarHeight: CGFloat = 88
                let tabBarHeight: CGFloat = 83
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createPhoneXPortraitDisplay(newHeight: screenHeight, newWidth: screenWidth)
                
            } else if UIDevice().userInterfaceIdiom == .pad {
                
                currentDevice = .iPadPortrait
                
                let navBarHeight: CGFloat = 64
                let tabBarHeight: CGFloat = 49
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createPadPortraitDisplay(newHeight: screenHeight, newWidth: screenWidth)
                
            } else {
                
                currentDevice = .iPhonePortrait
                
                let navBarHeight: CGFloat = 64
                let tabBarHeight: CGFloat = 49
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createPhonePortraitDisplay(newHeight: screenHeight, newWidth: screenWidth)
                
            }
        }
        
    }
    
}

//MARK:  iPhone Layouts

extension ProfileViewController {
    
    private func createPhoneLandscapeDisplay(newHeight: CGFloat, newWidth: CGFloat) {
        
        let dimension = (newWidth / 2 - 2) / 3
        gridItemSize = dimension
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView.frame = CGRect(x: newWidth / 2, y: 0, width: newWidth / 2 , height: newHeight)
        
        if isGrid {
            layout.itemSize = CGSize(width: dimension, height: dimension)
        } else {
            layout.itemSize = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
        }
        
        layout.headerReferenceSize = CGSize(width: newWidth / 2 , height: newWidth / 15 )
        
        collectionView.collectionViewLayout = layout
        
        profileLandscapeView.frame = CGRect(x: 0, y: 0, width: newWidth / 2, height: newHeight)
        
        profileImageView.frame = CGRect(x: newWidth / 4 - newHeight / 8, y: newHeight / 6,
                                        width: newHeight / 4, height: newHeight / 4)
        
        profileImageView.layer.cornerRadius = newHeight / 8
        
        let imageHeight = profileImageView.frame.height
        
        recipesLabel.frame = CGRect(x: newWidth / 4 - imageHeight / 2 , y: newHeight / 6 + imageHeight,
                                    width: imageHeight, height: newHeight / 9)
        
        recipesLabel.font = recipesLabel.font.withSize(newHeight / 12)
        
        let recipesLabelHeight = recipesLabel.frame.height
        
        recipesCountLabel.frame = CGRect(x: newWidth / 4 - imageHeight / 2, y: newHeight / 6 + imageHeight + recipesLabelHeight,
                                         width: imageHeight, height: recipesLabelHeight * 1.5)
        
        recipesCountLabel.font = recipesCountLabel.font.withSize(newHeight /  8 )
        
    }
    
    private func createPhonePortraitDisplay(newHeight: CGFloat, newWidth: CGFloat) {
        
        let dimension = (newWidth - 2) / 3
        gridItemSize = dimension
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        if isGrid {
            layout.itemSize = CGSize(width: dimension, height: dimension)
        } else {
            layout.itemSize = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
        }
        
        layout.headerReferenceSize = CGSize(width: newWidth, height: newHeight / 3 )
        
        collectionView.collectionViewLayout = layout
        
    }
    
}

//MARK: iPhone X Layouts

extension ProfileViewController {
    
    private func createPhoneXLandscapeDisplay(newHeight: CGFloat, newWidth: CGFloat) {
        
        collectionView.frame = CGRect(x: newWidth / 2, y: 0, width: newWidth / 2, height: newHeight)
        
        let dimension = (collectionView.frame.width - 2) / 3
        gridItemSize = dimension
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        if isGrid {
            layout.itemSize = CGSize(width: dimension, height: dimension)
        } else {
            layout.itemSize = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
        }
        
        
        layout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: newWidth / 15 )
        
        collectionView.collectionViewLayout = layout
        
        profileLandscapeView.frame = CGRect(x: 0, y: 0, width: newWidth / 2, height: newHeight + 32)
        
        profileImageView.frame = CGRect(x: newWidth / 4 - newHeight / 8 , y: newHeight / 4,
                                        width: newHeight / 4, height: newHeight / 4)
        
        profileImageView.layer.cornerRadius = newHeight / 8
        
        let imageHeight = profileImageView.frame.height
        
        recipesLabel.frame = CGRect(x: newWidth / 4 - imageHeight / 2, y: newHeight / 4 + imageHeight,
                                    width: imageHeight, height: newHeight / 9)
        
        recipesLabel.font = recipesLabel.font.withSize(newHeight / 12)
        
        let recipesLabelHeight = recipesLabel.frame.height
        
        recipesCountLabel.frame = CGRect(x: newWidth / 4 - imageHeight / 2, y: newHeight / 4 + imageHeight + recipesLabelHeight,
                                         width: imageHeight , height: recipesLabelHeight * 1.5)
        
        recipesCountLabel.font = recipesCountLabel.font.withSize(newHeight /  8 )
        
    }
    
    private func createPhoneXPortraitDisplay(newHeight: CGFloat, newWidth: CGFloat) {
        
        let dimension = (newWidth - 2) / 3
        gridItemSize = dimension
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        collectionView.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        if isGrid {
            layout.itemSize = CGSize(width: dimension, height: dimension)
        } else {
            layout.itemSize = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
        }
        
        layout.headerReferenceSize = CGSize(width: newWidth, height: newHeight / 3 )
        collectionView.collectionViewLayout = layout
        
    }
    
}

extension ProfileViewController {
    
    private func createPadLandscapeDisplay(newHeight: CGFloat, newWidth: CGFloat) {
        
        let dimension = (newWidth / 2 - 2) / 3
        gridItemSize = dimension
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView.frame = CGRect(x: newWidth / 2, y: 0, width: newWidth / 2 , height: newHeight)
        
        if isGrid {
            layout.itemSize = CGSize(width: dimension, height: dimension)
        } else {
            layout.itemSize = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
        }
        
        layout.headerReferenceSize = CGSize(width: newWidth / 2 , height: newWidth / 15 )
        
        collectionView.collectionViewLayout = layout
        
        profileLandscapeView.frame = CGRect(x: 0, y: 0, width: newWidth / 2, height: newHeight)
        
        profileImageView.frame = CGRect(x: newWidth / 4 - newHeight / 8, y: newHeight / 4,
                                        width: newHeight / 4, height: newHeight / 4)
        
        profileImageView.layer.cornerRadius = newHeight / 8
        
        let imageHeight = profileImageView.frame.height
        
        recipesLabel.frame = CGRect(x: newWidth / 4 - imageHeight / 2 , y: newHeight / 4 + imageHeight,
                                    width: imageHeight, height: newHeight / 9)
        
        recipesLabel.font = recipesLabel.font.withSize(newHeight / 12)
        
        let recipesLabelHeight = recipesLabel.frame.height
        
        recipesCountLabel.frame = CGRect(x: newWidth / 4 - imageHeight / 2, y: newHeight / 4 + imageHeight + recipesLabelHeight,
                                         width: imageHeight, height: recipesLabelHeight * 1.5)
        
        recipesCountLabel.font = recipesCountLabel.font.withSize(newHeight /  8 )
        
    }
    
    private func createPadPortraitDisplay(newHeight: CGFloat, newWidth: CGFloat) {
        
        let dimension = (newWidth - 3) / 4
        gridItemSize = dimension
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        if isGrid {
            layout.itemSize = CGSize(width: dimension, height: dimension)
        } else {
            layout.itemSize = CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.width)
        }
        
        layout.headerReferenceSize = CGSize(width: newWidth, height: newHeight / 2.7 )
        
        collectionView.collectionViewLayout = layout
        
    }
    
}

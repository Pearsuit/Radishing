//
//  AddPhotoLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/30/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension AddPhotoViewController {
    
}

//MARK: Main Function

extension AddPhotoViewController: ResponsiveLayoutable {
    func conformLayoutToDisplay(size: CGSize) {
        
        var (newWidth, newHeight) = (size.width, size.height)
        
        //iPad seems to have the new UIScreen dimensions before the process starts, so it does not need the swap out the dimensions
        
        if hasAppearedAlready && UIDevice().userInterfaceIdiom != .pad {
            (newWidth, newHeight) = (size.height, size.width)
        }
        
        if (newWidth / newHeight) > 1 { //Landscape
            
            if (newWidth / newHeight) > 2.1 { //iPhone X
                
                currentDevice = .iPhoneXLandscape
                
                let navBarHeight: CGFloat = 32
                let tabBarHeight: CGFloat = 53
                let sidePadding: CGFloat = 64
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth - sidePadding * 2
                
                containerView.frame = CGRect(x: sidePadding, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createLandscapeLayout(screenHeight: screenHeight, screenWidth: screenWidth, numberOfCellsInRow: 3)
                
            } else if (newWidth / newHeight) < 1.4 { //iPad
                
                currentDevice = .iPadLandscape
                
                let navBarHeight: CGFloat = 32
                let tabBarHeight: CGFloat = 32
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createLandscapeLayout(screenHeight: screenHeight, screenWidth: screenWidth, numberOfCellsInRow: 2)
                
            } else { //iPhone
                
                currentDevice = .iPhoneLandscape
                
                let navBarHeight: CGFloat =  newWidth > 700 ? 44 : 32
                let tabBarHeight: CGFloat = newWidth > 700 ? 44 : 32
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createLandscapeLayout(screenHeight: screenHeight, screenWidth: screenWidth, numberOfCellsInRow: 4)
                
            }
        } else { // Portrait
            
            if (newHeight / newWidth) > 2 { //iPhone X
                
                currentDevice = .iPhoneXPortrait
                
                let navBarHeight: CGFloat = 88
                let tabBarHeight: CGFloat = 83
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createPortraitLayout(screenHeight: screenHeight, screenWidth: screenWidth)
                
            } else if (newHeight / newWidth) < 1.4 { //iPad
                
                currentDevice = .iPadPortrait
                
                let navBarHeight: CGFloat = 44
                let tabBarHeight: CGFloat = 49
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createPortraitLayout(screenHeight: screenHeight, screenWidth: screenWidth)
                
            } else { //iPhone
                
                currentDevice = .iPhonePortrait
                
                let navBarHeight: CGFloat = 44
                let tabBarHeight: CGFloat = 49
                let screenHeight = newHeight - navBarHeight - tabBarHeight
                let screenWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: screenWidth, height: screenHeight)
                
                createPortraitLayout(screenHeight: screenHeight, screenWidth: screenWidth)
                
            }
        }
    }
    
}

//MARK: Layout Functions


extension AddPhotoViewController {
    
    private func createLandscapeLayout(screenHeight: CGFloat, screenWidth: CGFloat, numberOfCellsInRow: CGFloat) {
        
        let selectedPhotoImageViewWidth = screenHeight
        let collectionViewWidth = screenWidth - selectedPhotoImageViewWidth - 1
        
        selectedPhotoImageView.isHidden = false
        
        selectedPhotoImageView.frame = CGRect(x: 0, y: 0,
                                              width: selectedPhotoImageViewWidth, height: selectedPhotoImageViewWidth)
        
        let dimension = ( collectionViewWidth - (numberOfCellsInRow - 1) ) / numberOfCellsInRow
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: dimension, height: dimension)
        layout.headerReferenceSize = CGSize(width: collectionViewWidth, height: 1 )
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView.frame = CGRect(x: selectedPhotoImageViewWidth + 1, y: 0,
                                      width: collectionViewWidth , height: screenHeight)
        
        collectionView.collectionViewLayout = layout
    }
    
    private func createPortraitLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        selectedPhotoImageView.isHidden = true
        
        let dimension = (screenWidth - 3) / 4
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: dimension, height: dimension)
        layout.headerReferenceSize = CGSize(width: screenWidth, height: screenWidth )
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        
        collectionView.frame = CGRect(x: 0, y: 0,
                                      width: screenWidth, height: screenHeight)
        
        collectionView.collectionViewLayout = layout
        
    }
}

//
//  SearchPhotoLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension SearchPhotoViewController: ResponsiveLayoutable {
    
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
                let sideSpacing: CGFloat = 64
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth - sideSpacing * 2
                
                containerView.frame = CGRect(x: sideSpacing, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                createPhoneXLandscapeDisplay(screenHeight: containerHeight, screenWidth: containerWidth)
                
            } else if (newWidth / newHeight) < 1.4 { //iPad
                
                currentDevice = .iPadLandscape
                
                let navBarHeight: CGFloat = 44
                let tabBarHeight: CGFloat = 44
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                createPadLandscapeDisplay(screenHeight: containerHeight, screenWidth: containerWidth)
                
            } else {
                
                currentDevice = .iPhoneLandscape
                
                let navBarHeight: CGFloat =  newWidth > 700 ? 44 : 32
                let tabBarHeight: CGFloat = newWidth > 700 ? 44 : 32
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                createPhoneLandscapeDisplay(screenHeight: containerHeight, screenWidth: containerWidth)
                
            }
        } else {
            
            if (newHeight / newWidth) > 2 {
                
                currentDevice = .iPhoneXPortrait
                
                let navBarHeight: CGFloat = 88
                let tabBarHeight: CGFloat = 83
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                createPhoneXPortraitDisplay(screenHeight: containerHeight, screenWidth: containerWidth)
                
            } else if (newHeight / newWidth) < 1.4 {
                
                currentDevice = .iPadPortrait
                
                let navBarHeight: CGFloat = 44
                let tabBarHeight: CGFloat = 49
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                createPadPortraitDisplay(screenHeight: containerHeight, screenWidth: containerWidth)
                
            } else {
                
                currentDevice = .iPhonePortrait
                
                let navBarHeight: CGFloat = 44
                let tabBarHeight: CGFloat = 49
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                createPhonePortraitDisplay(screenHeight: containerHeight, screenWidth: containerWidth)
                
            }
        }
    }
    
}

//MARK: iPhone Layouts

extension SearchPhotoViewController {
    
    private func createPhoneLandscapeDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenHeight * 0.75
        let tfHeight = screenHeight /  8
        
        searchTextField.font = searchTextField.font?.withSize(tfHeight * 0.3125 )
        
        searchContainerView.frame = CGRect(x: 0, y: 0,
                                           width: screenWidth, height: screenHeight / 5 )
        
        searchTextField.frame = CGRect(x: screenWidth / 40, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                       width: tfWidth, height: tfHeight)
        
        searchButton.frame = CGRect(x: searchTextField.frame.width + screenWidth / 20, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                    width: tfHeight, height: tfHeight)
        
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        
        activityIndicator.frame = CGRect(x: searchButton.frame.height / 2 - 18, y: searchButton.frame.height / 2 - 18,
                                         width: 37, height: 37 )
        
        
        let dimension = (screenWidth - 4) / 5
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: dimension, height: dimension)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView.frame = CGRect(x: 0, y: searchContainerView.frame.height,
                                      width: screenWidth , height: screenHeight - searchContainerView.frame.height)
        
        
        collectionView.collectionViewLayout = layout
        
    }
    
    private func createPhonePortraitDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenWidth * 0.75
        let tfHeight = screenWidth /  8
        
        searchTextField.font = searchTextField.font?.withSize(tfHeight * 0.3125 )
        
        searchContainerView.frame = CGRect(x: 0, y: 0,
                                           width: screenWidth, height: screenHeight / 8 )
        
        searchTextField.frame = CGRect(x: screenWidth / 20, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                       width: tfWidth, height: tfHeight)
        
        searchButton.frame = CGRect(x: searchTextField.frame.width + screenWidth / 10, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                    width: tfHeight, height: tfHeight)
        
        
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        
        activityIndicator.frame = CGRect(x: searchButton.frame.height / 2 - 18, y: searchButton.frame.height / 2 - 18,
                                         width: 37, height: 37 )
        
        
        let dimension = (screenWidth - 2) / 3
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: dimension, height: dimension)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView.frame = CGRect(x: 0, y: searchContainerView.frame.height,
                                      width: screenWidth , height: screenHeight - searchContainerView.frame.height)
        
        
        collectionView.collectionViewLayout = layout
    
    }
    
}

//MARK: iPhone X Layuots

extension SearchPhotoViewController {
    
    private func createPhoneXLandscapeDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenHeight * 0.75
        let tfHeight = screenHeight /  8
        
        searchTextField.font = searchTextField.font?.withSize(tfHeight * 0.3125 )
        
        searchContainerView.frame = CGRect(x: 0, y: 0,
                                           width: screenWidth, height: screenHeight / 5 )
        
        searchTextField.frame = CGRect(x: screenWidth / 40, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                       width: tfWidth, height: tfHeight)
        
        searchButton.frame = CGRect(x: searchTextField.frame.width + screenWidth / 20, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                    width: tfHeight, height: tfHeight)
        
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        
        activityIndicator.frame = CGRect(x: searchButton.frame.height / 2 - 18, y: searchButton.frame.height / 2 - 18,
                                         width: 37, height: 37 )
        
        let dimension = (screenWidth - 4) / 5
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: dimension, height: dimension)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView.frame = CGRect(x: 0, y: searchContainerView.frame.height,
                                      width: screenWidth , height: screenHeight - searchContainerView.frame.height)
        
        
        collectionView.collectionViewLayout = layout

        
        
    }
    
    private func createPhoneXPortraitDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenWidth * 0.75
        let tfHeight = screenWidth /  8
        
        searchTextField.font = searchTextField.font?.withSize(tfHeight * 0.3125 )
        
        searchContainerView.frame = CGRect(x: 0, y: 0,
                                           width: screenWidth, height: screenHeight / 8 )
        
        searchTextField.frame = CGRect(x: screenWidth / 20, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                       width: tfWidth, height: tfHeight)
        
        searchButton.frame = CGRect(x: searchTextField.frame.width + screenWidth / 10, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                    width: tfHeight, height: tfHeight)
        
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        
        activityIndicator.frame = CGRect(x: searchButton.frame.height / 2 - 18, y: searchButton.frame.height / 2 - 18,
                                         width: 37, height: 37 )
        
        let dimension = (screenWidth - 2) / 3
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: dimension, height: dimension)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView.frame = CGRect(x: 0, y: searchContainerView.frame.height,
                                      width: screenWidth , height: screenHeight - searchContainerView.frame.height)
        
        
        collectionView.collectionViewLayout = layout
        
    }
    
}

//MARK: iPad Layouts

extension SearchPhotoViewController {
    
    private func createPadLandscapeDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenHeight * 0.75
        let tfHeight = screenHeight /  16
        
        searchTextField.font = searchTextField.font?.withSize(tfHeight * 0.3125 )
        
        searchContainerView.frame = CGRect(x: 0, y: 0,
                                           width: screenWidth, height: screenHeight / 10 )
        
        searchTextField.frame = CGRect(x: screenWidth / 40, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                       width: tfWidth, height: tfHeight)
        
        searchButton.frame = CGRect(x: searchTextField.frame.width + screenWidth / 20, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                    width: tfHeight, height: tfHeight)
        
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        
        activityIndicator.frame = CGRect(x: searchButton.frame.height / 2 - 18, y: searchButton.frame.height / 2 - 18,
                                         width: 37, height: 37 )
        
        
        let dimension = (screenWidth - 4) / 5
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: dimension, height: dimension)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView.frame = CGRect(x: 0, y: searchContainerView.frame.height,
                                      width: screenWidth , height: screenHeight - searchContainerView.frame.height)
        
        
        collectionView.collectionViewLayout = layout

        
    }
    
    private func createPadPortraitDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenWidth * 0.75
        let tfHeight = screenWidth /  16
        
        searchTextField.font = searchTextField.font?.withSize(tfHeight * 0.3125 )
        
        searchContainerView.frame = CGRect(x: 0, y: 0,
                                           width: screenWidth, height: screenHeight / 15 )
        
        searchTextField.frame = CGRect(x: screenWidth / 20, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                       width: tfWidth, height: tfHeight)
        
        searchButton.frame = CGRect(x: searchTextField.frame.width + screenWidth / 10, y: searchContainerView.frame.height / 2 - tfHeight / 2,
                                    width: tfHeight, height: tfHeight)
        
        searchButton.layer.cornerRadius = searchButton.frame.height / 2
        
        activityIndicator.frame = CGRect(x: searchButton.frame.height / 2 - 18, y: searchButton.frame.height / 2 - 18,
                                         width: 37, height: 37 )
        
        
        let dimension = (screenWidth - 3) / 4
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: dimension, height: dimension)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView.frame = CGRect(x: 0, y: searchContainerView.frame.height,
                                      width: screenWidth , height: screenHeight - searchContainerView.frame.height)
        
        
        collectionView.collectionViewLayout = layout
        
    }
    
}

//
//  CreateRecipeLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/2/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension CreateRecipeViewController: ResponsiveLayoutable {
    
    func conformLayoutToDisplay(size: CGSize) {
        
        var (newWidth, newHeight) = (size.width, size.height)
        
        //iPad seems to have the new UIScreen dimensions before the process starts, so it does not need the swap out the dimensions
        
        if hasAppearedAlready && UIDevice().userInterfaceIdiom != .pad {
            (newWidth, newHeight) = (size.height, size.width)
        }
        
        if (newWidth / newHeight) > 1 { //Landscape
            
            activityIndicator.frame = CGRect(x: newWidth / 2 - newHeight / 10, y: newHeight / 2 - newHeight / 10,
                                             width: newHeight / 5 , height: newHeight / 5)
            
            if (newWidth / newHeight) > 2.1 { //iPhone X
                
                currentDevice = .iPhoneXLandscape
                
                let navBarHeight: CGFloat = 32
                let tabBarHeight: CGFloat = 53
                let sidePadding: CGFloat = 64
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth - sidePadding * 2
                
                containerView.frame = CGRect(x: 64, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                
                createPhoneXLandscapeLayout(screenHeight: containerHeight, screenWidth: containerWidth)
                
            } else if (newWidth / newHeight) < 1.4 {//iPad
                
                currentDevice = .iPadLandscape
                
                let navBarHeight: CGFloat = 32
                let tabBarHeight: CGFloat = 32
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                
                createPadLandscapeLayout(screenHeight: containerHeight, screenWidth: containerWidth)
                
            } else { //iPhone
                
                currentDevice = .iPhoneLandscape
                
                let navBarHeight: CGFloat =  newWidth > 700 ? 44 : 32
                let tabBarHeight: CGFloat = newWidth > 700 ? 44 : 32
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                createPhoneLandscapeLayout(screenHeight: containerHeight, screenWidth: containerWidth)
                
            }
        } else { // Portrait
            
            activityIndicator.frame = CGRect(x: newWidth / 2 - newWidth / 10, y: newHeight / 2 - newWidth / 10,
                                             width: newWidth / 5 , height: newWidth / 5)
            
            if (newHeight / newWidth) > 2 { //iPhone X
                
                currentDevice = .iPhoneXPortrait
                
                let navBarHeight: CGFloat = 88
                let tabBarHeight: CGFloat = 83
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                
                createPhoneXPortraitLayout(screenHeight: containerHeight, screenWidth: containerWidth)
                
            } else if (newHeight / newWidth) < 1.4 { //iPad
                
                currentDevice = .iPadPortrait
                
                let navBarHeight: CGFloat = 44
                let tabBarHeight: CGFloat = 49
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                
                createPadPortraitLayout(screenHeight: containerHeight, screenWidth: containerWidth)
                
            } else { //iPhone
                
                currentDevice = .iPhonePortrait
                let navBarHeight: CGFloat = 44
                let tabBarHeight: CGFloat = 49
                
                let containerHeight = newHeight - navBarHeight - tabBarHeight
                let containerWidth = newWidth
                
                containerView.frame = CGRect(x: 0, y: navBarHeight,
                                             width: containerWidth, height: containerHeight)
                
                
                createPhonePortraitLayout(screenHeight: containerHeight, screenWidth: containerWidth)
                
            }
        }
    }
    
}

// iPhone Layouts

extension CreateRecipeViewController {
    
    private func createPhoneLandscapeLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        imageView.frame = CGRect(x: screenWidth / 2 - screenHeight / 4 , y: screenHeight / 16,
                                 width: screenHeight / 2, height: screenHeight / 2)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 6
        
    }
    
    private func createPhonePortraitLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        imageView.frame = CGRect(x: screenWidth / 4 , y: screenHeight / 16,
                                 width: screenWidth / 2 , height: screenWidth / 2)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 6
        
    }
    
}

// iPhone X Layouts

extension CreateRecipeViewController {
    
    private func createPhoneXLandscapeLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        createPhoneLandscapeLayout(screenHeight: screenHeight, screenWidth: screenWidth)

        
    }
    
    private func createPhoneXPortraitLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        createPhonePortraitLayout(screenHeight: screenHeight, screenWidth: screenWidth)
        
    }
    
}

// iPad Layouts

extension CreateRecipeViewController {
    
    private func createPadLandscapeLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        imageView.frame = CGRect(x: screenWidth / 2 - screenHeight / 6 , y: screenHeight / 20,
                                 width: screenHeight / 3, height: screenHeight / 3)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 6
        
        
    }
    
    private func createPadPortraitLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        imageView.frame = CGRect(x: screenWidth / 3 , y: screenHeight / 16,
                                 width: screenWidth / 3 , height: screenWidth / 3)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 6
        
        
    }
    
}



//
//  ViewRecipeLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/2/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

import UIKit

extension ViewRecipeViewController: ResponsiveLayoutable {
    
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
                
                
                createPhoneXLandscapeLayout(screenHeight: newHeight, screenWidth: newWidth)
                
            } else if (newWidth / newHeight) < 1.4 {//iPad
                
                currentDevice = .iPadLandscape
                
                createPadLandscapeLayout(screenHeight: newHeight, screenWidth: newWidth)
                
            } else { //iPhone
                
                currentDevice = .iPhoneLandscape
                
                createPhoneLandscapeLayout(screenHeight: newHeight, screenWidth: newWidth)
                
            }
        } else { // Portrait
            
            activityIndicator.frame = CGRect(x: newWidth / 2 - newWidth / 10, y: newHeight / 2 - newWidth / 10,
                                             width: newWidth / 5 , height: newWidth / 5)
            
            if (newHeight / newWidth) > 2 { //iPhone X
                
                currentDevice = .iPhoneXPortrait
                
                createPhoneXPortraitLayout(screenHeight: newHeight, screenWidth: newWidth)
                
            } else if (newHeight / newWidth) < 1.4 { //iPad
                
                currentDevice = .iPadPortrait
                
                createPadPortraitLayout(screenHeight: newHeight, screenWidth: newWidth)
                
            } else { //iPhone
                
                currentDevice = .iPhonePortrait
                
                
                createPhonePortraitLayout(screenHeight: newHeight, screenWidth: newWidth)
                
            }
        }
    }
    
}

// iPhone Layouts

extension ViewRecipeViewController {
    
    private func createPhoneLandscapeLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        imageView.frame = CGRect(x: screenWidth / 6 - screenHeight / 4 , y: screenHeight / 4 - 16,
                                 width: screenHeight / 2, height: screenHeight / 2)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 6
        
        textView.frame = CGRect(x:  screenWidth / 3, y: screenHeight / 8 - 16 ,
                                width: screenWidth - screenWidth / 3 - ((screenWidth / 3 - screenHeight / 2) / 2 ), height: screenHeight * 0.75)
        
        textView.layer.cornerRadius  = textView.frame.size.height / 20
        
    }
    
    private func createPhonePortraitLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        imageView.frame = CGRect(x: screenWidth / 4 , y: screenHeight / 16,
                                 width: screenWidth / 2 , height: screenWidth / 2)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 6
        
        textView.frame = CGRect(x: screenWidth / 2 - screenWidth * 0.375, y: screenHeight / 8 + screenWidth / 2 ,
                                width: screenWidth * 0.75 , height: screenHeight * 0.5 )
        
        
        textView.layer.cornerRadius  = textView.frame.size.height / 20
        
    }
    
}

// iPhone X Layouts

extension ViewRecipeViewController {
    
    private func createPhoneXLandscapeLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        imageView.frame = CGRect(x: screenWidth / 6 - screenHeight / 4 , y: screenHeight / 4 - 16,
                                 width: screenHeight / 2, height: screenHeight / 2)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 6
        
        textView.frame = CGRect(x:  screenWidth / 3, y: screenHeight / 8 - 16 ,
                                width: screenWidth - screenWidth / 3 - ((screenWidth / 3 - screenHeight / 2) / 2 ), height: screenHeight * 0.75)
        
        textView.layer.cornerRadius  = textView.frame.size.height / 20
        
        
    }
    
    private func createPhoneXPortraitLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        imageView.frame = CGRect(x: screenWidth / 4 , y: screenHeight / 16,
                                 width: screenWidth / 2 , height: screenWidth / 2)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 6
        
        textView.frame = CGRect(x: screenWidth / 2 - screenWidth * 0.375, y: screenHeight / 8 + screenWidth / 2 ,
                                width: screenWidth * 0.75 , height: screenHeight * 0.5 )
        
        
        textView.layer.cornerRadius  = textView.frame.size.height / 20
        
    }
    
}

// iPad Layouts

extension ViewRecipeViewController {
    
    private func createPadLandscapeLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        imageView.frame = CGRect(x: screenWidth / 6 - screenHeight / 6 , y: screenHeight / 2 - screenHeight / 6 - 16,
                                 width: screenHeight / 3, height: screenHeight / 3)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 6
        
        textView.frame = CGRect(x:  screenWidth / 3, y: screenHeight / 8 - 16 ,
                                width: screenWidth - screenWidth / 3 - ((screenWidth / 3 - screenHeight / 3) / 2 ), height: screenHeight * 0.75)
        
        textView.layer.cornerRadius  = textView.frame.size.height / 40
        
        
    }
    
    private func createPadPortraitLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        imageView.frame = CGRect(x: screenWidth / 3 , y: screenHeight / 16,
                                 width: screenWidth / 3 , height: screenWidth / 3)
        
        imageView.layer.cornerRadius = imageView.frame.size.height / 6
        
        textView.frame = CGRect(x: screenWidth / 2 - screenWidth * 0.375, y: screenHeight / 8 + screenWidth / 3,
                                width: screenWidth * 0.75 , height: screenHeight * 0.5 )
        
        
        textView.layer.cornerRadius  = textView.frame.size.height / 20
        
    }
    
}

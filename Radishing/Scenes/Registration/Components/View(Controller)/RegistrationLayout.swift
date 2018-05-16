//
//  RegistrationLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension RegistrationViewController: ResponsiveLayoutable {
    func conformLayoutToDisplay(size: CGSize) {
        let (newWidth, newHeight) = (size.width, size.height)
        
        if (newWidth / newHeight) > 1 { //Landscape
            
            if (newWidth / newHeight) > 2 { //iPhone X
                
                currentDevice = .iPhoneXLandscape
                
                createPhoneXLandscapeDisplay(screenHeight: newHeight, screenWidth: newWidth)
                
            } else if (newWidth / newHeight) < 1.4 { //iPad
                
                currentDevice = .iPadLandscape
                
                createPadLandscapeDisplay(screenHeight: newHeight, screenWidth: newWidth)
                
            } else {
                
                currentDevice = .iPhoneLandscape
                
                createPhoneLandscapeDisplay(screenHeight: newHeight, screenWidth: newWidth)
                
            }
        } else {
            
            if (newHeight / newWidth) > 2 {
                
                currentDevice = .iPhoneXPortrait
                
                createPhoneXPortraitDisplay(screenHeight: newHeight, screenWidth: newWidth)
                
            } else if (newHeight / newWidth) < 1.4 {
                
                currentDevice = .iPadPortrait
                
                createPadPortraitDisplay(screenHeight: newHeight, screenWidth: newWidth)
                
            } else {
                
                currentDevice = .iPhonePortrait
                
                createPhonePortraitDisplay(screenHeight: newHeight, screenWidth: newWidth)
                
            }
        }
    }
}

extension RegistrationViewController {
    
    private func createPhoneLandscapeDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenHeight * 0.75
        let tfHeight = screenHeight /  8
        let tfCenterX = (screenWidth * 0.75 ) - (tfWidth / 2)
        let tfCenterY =  screenHeight / 2 - tfHeight / 2
        
        //Text Sizes
        
        changeTextSizes(tfHeight: tfHeight)
        
        // View Sizes
        
        photoButton.frame = CGRect(x: (screenWidth / 4) - (screenHeight / 4), y: screenHeight / 2 - (screenHeight / 4),
                                   width: screenHeight / 2, height: screenHeight / 2)
        
        
        
        emailTextField.frame = CGRect(x: tfCenterX, y: tfCenterY - 2 * screenHeight * 0.15,
                                      width: tfWidth, height: tfHeight)
        
        usernameTextField.frame = CGRect(x: tfCenterX, y: tfCenterY - screenHeight * 0.15,
                                         width: tfWidth, height: tfHeight)
        
        passwordTextField.frame = CGRect(x: tfCenterX, y: tfCenterY,
                                         width: tfWidth, height: tfHeight)
        
        reEnterPasswordTextField.frame = CGRect(x: tfCenterX, y: tfCenterY + screenHeight * 0.15,
                                                width: tfWidth, height: tfHeight)
        
        signUpButton.frame = CGRect(x: tfCenterX, y: tfCenterY + 2 * screenHeight * 0.15,
                                    width: tfWidth, height: tfHeight)
        
        
        
        dismissButton.frame = CGRect(x: screenHeight / 20, y: screenHeight / 20,
                                     width: screenHeight / 8, height: screenHeight / 8)
        
        //photoButton |> cornerRadius(of: addPhotoButton.frame.width / 2, maskToBounds: true)
        photoButton.layer.cornerRadius = photoButton.frame.width / 2
        photoButton.layer.masksToBounds = true
        
        processingIndicator.frame = CGRect(x: (tfWidth / 2) - tfHeight * 0.375 , y: tfHeight * 0.125,
                                           width: tfHeight * 0.75, height: tfHeight * 0.75)
        
    }
    
    private func createPhonePortraitDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenWidth * 0.75
        let tfHeight = screenWidth /  8
        let tfCenterX = (screenWidth / 2) - (tfWidth / 2)
        
        //Text Sizes
        
        changeTextSizes(tfHeight: tfHeight)
        
        // View Sizes
        
        photoButton.frame = CGRect(x: (screenWidth / 2) - (screenHeight/8) , y:  screenHeight / 8,
                                   width: screenHeight / 4, height: screenHeight / 4)
        
        
        
        emailTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 0.7,
                                      width: tfWidth, height: tfHeight)
        
        usernameTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 0.85,
                                         width: tfWidth, height: tfHeight)
        
        passwordTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 1,
                                         width: tfWidth, height: tfHeight)
        
        reEnterPasswordTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 1.15,
                                                width: tfWidth, height: tfHeight)
        
        signUpButton.frame = CGRect(x: tfCenterX, y: screenWidth * 1.3,
                                    width: tfWidth, height: tfHeight)
        
        
        
        dismissButton.frame = CGRect(x: screenWidth / 20, y: screenWidth / 20, width: screenWidth / 8, height: screenWidth / 8)
        
        photoButton.layer.cornerRadius = photoButton.frame.width / 2
        photoButton.layer.masksToBounds = true
        
        processingIndicator.frame = CGRect(x: (tfWidth / 2) - tfHeight * 0.375 , y: tfHeight * 0.125,
                                           width: tfHeight * 0.75, height: tfHeight * 0.75)
        
    }
    
}

extension RegistrationViewController {
    
    private func createPadLandscapeDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenHeight * 0.60
        let tfHeight = screenHeight /  10
        let tfCenterX = (screenWidth * 0.75 ) - (tfWidth / 2)
        let tfCenterY =  screenHeight / 2 - tfHeight / 2
        
        //Text Sizes
        
        changeTextSizes(tfHeight: tfHeight)
        
        // View Sizes
        
        photoButton.frame = CGRect(x: (screenWidth / 4) - (screenWidth / 8), y: screenHeight / 2 - (screenWidth / 8),
                                   width: screenWidth / 4, height: screenWidth / 4)
        
        
        emailTextField.frame = CGRect(x: tfCenterX, y: tfCenterY - screenHeight * 0.24,
                                      width: tfWidth, height: tfHeight)
        
        usernameTextField.frame = CGRect(x: tfCenterX, y: tfCenterY - screenHeight * 0.12,
                                         width: tfWidth, height: tfHeight)
        
        passwordTextField.frame = CGRect(x: tfCenterX, y: tfCenterY,
                                         width: tfWidth, height: tfHeight)
        
        reEnterPasswordTextField.frame = CGRect(x: tfCenterX, y: tfCenterY + screenHeight * 0.12,
                                                width: tfWidth, height: tfHeight)
        
        signUpButton.frame = CGRect(x: tfCenterX, y: tfCenterY + screenHeight * 0.24,
                                    width: tfWidth, height: tfHeight)
        
        
        
        dismissButton.frame = CGRect(x: screenHeight / 40, y: screenHeight / 40,
                                     width: screenHeight / 16, height: screenHeight / 16)
        
        //photoButton |> cornerRadius(of: addPhotoButton.frame.width / 2, maskToBounds: true)
        photoButton.layer.cornerRadius = photoButton.frame.width / 2
        photoButton.layer.masksToBounds = true
        
        processingIndicator.frame = CGRect(x: (tfWidth / 2) - tfHeight * 0.375 , y: tfHeight * 0.125,
                                           width: tfHeight * 0.75, height: tfHeight * 0.75)
        
    }
    
    private func createPadPortraitDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenWidth * 0.60
        let tfHeight = screenWidth /  10
        let tfCenterX = (screenWidth / 2) - (tfWidth / 2)
        
        //Text Sizes
        
        changeTextSizes(tfHeight: tfHeight)
        
        // View Sizes
        
        photoButton.frame = CGRect(x: (screenWidth / 2) - (screenHeight/8) , y:  screenHeight / 8,
                                   width: screenHeight / 4, height: screenHeight / 4)
        
        
        
        emailTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 0.55,
                                      width: tfWidth, height: tfHeight)
        
        usernameTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 0.67,
                                         width: tfWidth, height: tfHeight)
        
        passwordTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 0.79,
                                         width: tfWidth, height: tfHeight)
        
        reEnterPasswordTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 0.91,
                                                width: tfWidth, height: tfHeight)
        
        signUpButton.frame = CGRect(x: tfCenterX, y: screenWidth * 1.03,
                                    width: tfWidth, height: tfHeight)
        
        
        
        dismissButton.frame = CGRect(x: screenWidth / 40, y: screenWidth / 40,
                                     width: screenWidth / 16, height: screenWidth / 16)
        
        photoButton.layer.cornerRadius = photoButton.frame.width / 2
        photoButton.layer.masksToBounds = true
        
        processingIndicator.frame = CGRect(x: (tfWidth / 2) - tfHeight * 0.375 , y: tfHeight * 0.125,
                                           width: tfHeight * 0.75, height: tfHeight * 0.75)
        
    }
    
}

extension RegistrationViewController {
    
    private func createPhoneXLandscapeDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenHeight * 0.75
        let tfHeight = screenHeight /  8
        let tfCenterX = (screenWidth * 0.75 ) - (tfWidth / 2)
        let tfCenterY =  screenHeight / 2 - tfHeight / 2
        
        //Text Sizes
        
        changeTextSizes(tfHeight: tfHeight)
        
        // View Sizes
        
        photoButton.frame = CGRect(x: (screenWidth / 4) - (screenHeight / 4), y: screenHeight / 2 - (screenHeight / 4),
                                   width: screenHeight / 2, height: screenHeight / 2)
        
        
        
        emailTextField.frame = CGRect(x: tfCenterX, y: tfCenterY - 2 * screenHeight * 0.15,
                                      width: screenHeight * 0.75, height: screenHeight / 8)
        
        usernameTextField.frame = CGRect(x: tfCenterX, y: tfCenterY - screenHeight * 0.15,
                                         width: screenHeight * 0.75, height: screenHeight / 8)
        
        passwordTextField.frame = CGRect(x: tfCenterX, y: tfCenterY,
                                         width: screenHeight * 0.75, height: screenHeight / 8)
        
        reEnterPasswordTextField.frame = CGRect(x: tfCenterX, y: tfCenterY + screenHeight * 0.15,
                                                width: screenHeight * 0.75, height: screenHeight / 8)
        
        signUpButton.frame = CGRect(x: tfCenterX, y: tfCenterY + 2 * screenHeight * 0.15,
                                    width: screenHeight * 0.75, height: screenHeight / 8)
        
        
        
        dismissButton.frame = CGRect(x: screenHeight / 20, y: screenHeight / 20,
                                     width: screenHeight / 8, height: screenHeight / 8)
        
        //photoButton |> cornerRadius(of: addPhotoButton.frame.width / 2, maskToBounds: true)
        photoButton.layer.cornerRadius = photoButton.frame.width / 2
        photoButton.layer.masksToBounds = true
        
        processingIndicator.frame = CGRect(x: (tfWidth / 2) - tfHeight * 0.375 , y: tfHeight * 0.125,
                                           width: tfHeight * 0.75, height: tfHeight * 0.75)
        
    }
    
    private func createPhoneXPortraitDisplay(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenWidth * 0.75
        let tfHeight = screenWidth /  8
        let tfCenterX = (screenWidth / 2) - (tfWidth / 2)
        
        //Text Sizes
        
        changeTextSizes(tfHeight: tfHeight)
        
        // View Sizes
        
        photoButton.frame = CGRect(x: (screenWidth / 2) - (screenHeight/8) , y:  screenHeight / 8,
                                   width: screenHeight / 4, height: screenHeight / 4)
        
        
        
        emailTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 0.85,
                                      width: tfWidth, height: tfHeight)
        
        usernameTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 1,
                                         width: tfWidth, height: tfHeight)
        
        passwordTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 1.15,
                                         width: tfWidth, height: tfHeight)
        
        reEnterPasswordTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 1.3,
                                                width: tfWidth, height: tfHeight)
        
        signUpButton.frame = CGRect(x: tfCenterX, y: screenWidth * 1.45,
                                    width: tfWidth, height: tfHeight)
        
        
        
        dismissButton.frame = CGRect(x: screenWidth / 20, y: screenWidth / 8,
                                     width: screenWidth / 8, height: screenWidth / 8)
        
        
        photoButton.layer.cornerRadius = photoButton.frame.width / 2
        photoButton.layer.masksToBounds = true
        
        processingIndicator.frame = CGRect(x: (tfWidth / 2) - tfHeight * 0.375 , y: tfHeight * 0.125,
                                           width: tfHeight * 0.75, height: tfHeight * 0.75)
        
    }
}


//Text Size Calculations

extension RegistrationViewController {
    
    private func changeTextSizes(tfHeight: CGFloat) {
        
        emailTextField.font = emailTextField.font?.withSize(tfHeight * 0.3125 )
        
        usernameTextField.font = usernameTextField.font?.withSize(tfHeight * 0.3125 )
        
        passwordTextField.font = passwordTextField.font?.withSize(tfHeight * 0.3125 )
        
        reEnterPasswordTextField.font = reEnterPasswordTextField.font?.withSize(tfHeight * 0.3125 )
        
        signUpButton.titleLabel?.font = signUpButton.titleLabel?.font.withSize(tfHeight * 0.375)
        
    }
}

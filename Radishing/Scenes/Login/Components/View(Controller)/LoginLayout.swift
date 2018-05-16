//
//  LoginLayout.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit


extension LoginViewController: ResponsiveLayoutable {
    func conformLayoutToDisplay(size: CGSize) {
        
        let (newWidth, newHeight) = (size.width, size.height)
        
        if (newWidth / newHeight) > 1 { //Landscape
            
            if (newWidth / newHeight) > 2 { //iPhone X
                
                currentDevice = .iPhoneXLandscape
                
                createPhoneXLandscapeLayout(screenHeight: newHeight, screenWidth: newWidth)
                
            } else if (newWidth / newHeight) < 1.4 { //iPad
                
                currentDevice = .iPadLandscape
                
                createPadLandscapeLayout(screenHeight: newHeight, screenWidth: newWidth)
                
            } else { //iPhone
                
                currentDevice = .iPhoneLandscape
                
                createPhoneLandscapeLayout(screenHeight: newHeight, screenWidth: newWidth)
                
            }
        } else { // Portrait
            
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

//MARK: iPhone Layouts

extension LoginViewController {
    
    private func createPhoneLandscapeLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        let tfWidth = screenHeight * 0.75
        let tfHeight = screenHeight /  8
        let tfCenterX = (screenWidth * 0.75 ) - (tfWidth / 2)
        let tfCenterY =  screenHeight / 2 - tfHeight / 2
        
        //Text Size
        
        changeTextSizes(tfHeight: tfHeight)
        
        //View Size
        
        rod1.frame = CGRect(x: tfHeight * 2, y: 0,
                            width: tfHeight * 0.2 , height: tfCenterY - tfHeight * 0.75)
        
        rod2.frame = CGRect(x: screenWidth / 2 - tfHeight * 2.2, y: 0,
                            width: tfHeight * 0.2 , height: tfCenterY - tfHeight * 0.75)
        
        backboard.frame = CGRect(x: (screenWidth * 0.25 ) - (tfWidth / 2), y: tfCenterY - tfHeight * 0.75,
                                 width: tfWidth, height: tfHeight * 2.5)
        
        titleLabel.frame = CGRect(x: tfWidth * 0.075, y: tfHeight / 4,
                                  width: tfWidth * 0.85, height: tfHeight * 2)

        screw1.frame = CGRect(x: tfHeight * 0.1 , y: tfHeight * 0.1,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw2.frame = CGRect(x: tfWidth * 0.85 - tfHeight * 0.3 , y: tfHeight * 0.1,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw3.frame = CGRect(x: tfHeight * 0.1 , y: tfHeight * 2 - tfHeight * 0.3,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw4.frame = CGRect(x: tfWidth * 0.85 - tfHeight * 0.3 , y: tfHeight * 2 - tfHeight * 0.3,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        [screw1, screw2, screw3, screw4].forEach { $0.layer.cornerRadius = tfHeight * 0.1 }
        
        signInLabel.frame = CGRect(x: tfCenterX, y: tfCenterY -  screenHeight * 0.3,
                                   width: tfWidth, height: tfHeight)
        
        emailTextField.frame = CGRect(x: tfCenterX, y: tfCenterY -  screenHeight * 0.15,
                                      width: tfWidth, height: tfHeight)
        
        passwordTextField.frame = CGRect(x: tfCenterX, y: tfCenterY,
                                         width: tfWidth, height: tfHeight)
        
        signInButton.frame = CGRect(x: tfCenterX, y: tfCenterY + screenHeight * 0.15,
                                    width: tfWidth, height: tfHeight)
        
        signUpButton.frame = CGRect(x: tfCenterX, y: screenHeight - (tfHeight * 1.15),
                                    width: tfWidth, height: tfHeight)
        
        processingIndicator.frame = CGRect(x: (tfWidth / 2) - tfHeight * 0.375 , y: tfHeight * 0.125,
                                           width: tfHeight * 0.75, height: tfHeight * 0.75)
    }
    
    private func createPhonePortraitLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenWidth * 0.75
        let tfHeight = screenWidth /  8
        let tfCenterX = (screenWidth / 2) - (tfWidth / 2)
        
        
        //Text Size
        
        changeTextSizes(tfHeight: tfHeight)
        
        //View Size
        
        rod1.frame = CGRect(x: tfHeight * 2, y: 0,
                            width: tfHeight * 0.2 , height: tfHeight * 1.5)
        
        rod2.frame = CGRect(x: screenWidth - tfHeight * 2.2, y: 0,
                            width: tfHeight * 0.2 , height: tfHeight * 1.5)
        
        backboard.frame = CGRect(x: tfCenterX, y: tfHeight * 1.5,
                                 width: tfWidth, height: tfHeight * 2.5)
        
        titleLabel.frame = CGRect(x: tfWidth * 0.075, y: tfHeight / 4,
                                  width: tfWidth * 0.85, height: tfHeight * 2)
        
        
        screw1.frame = CGRect(x: tfHeight * 0.1 , y: tfHeight * 0.1,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw2.frame = CGRect(x: tfWidth * 0.85 - tfHeight * 0.3 , y: tfHeight * 0.1,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw3.frame = CGRect(x: tfHeight * 0.1 , y: tfHeight * 2 - tfHeight * 0.3,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw4.frame = CGRect(x: tfWidth * 0.85 - tfHeight * 0.3 , y: tfHeight * 2 - tfHeight * 0.3,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        [screw1, screw2, screw3, screw4].forEach { $0.layer.cornerRadius = tfHeight * 0.1 }
        
        signInLabel.frame = CGRect(x: tfCenterX, y: screenWidth * 0.7,
                                   width: tfWidth, height: tfHeight)
        
        emailTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 0.85,
                                      width: tfWidth, height: tfHeight)
        
        passwordTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 1,
                                         width: tfWidth, height: tfHeight)
        
        signInButton.frame = CGRect(x: tfCenterX, y: screenWidth * 1.15,
                                    width: tfWidth, height: tfHeight)
        
        signUpButton.frame = CGRect(x: tfCenterX, y: screenHeight - (tfHeight * 1.15),
                                    width: tfWidth, height: tfHeight)
        
        processingIndicator.frame = CGRect(x: (tfWidth / 2) - tfHeight * 0.375 , y: tfHeight * 0.125,
                                           width: tfHeight * 0.75, height: tfHeight * 0.75)
        
    }
    
}

//MARK: iPhone X Layouts

extension LoginViewController {
    
    private func createPhoneXLandscapeLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        createPhoneLandscapeLayout(screenHeight: screenHeight, screenWidth: screenWidth)
    }
    
    private func createPhoneXPortraitLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        createPhonePortraitLayout(screenHeight: screenHeight, screenWidth: screenWidth)
    }
    
}

//MARK: iPad Layouts

extension LoginViewController {
    
    private func createPadLandscapeLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenHeight * 0.60
        let tfHeight = screenHeight /  10
        let tfCenterX = (screenWidth * 0.75 ) - (tfWidth / 2)
        let tfCenterY =  screenHeight / 2 - tfHeight / 2
        
        //Text Size
        
        changeTextSizes(tfHeight: tfHeight)
        
        //View Size
        
        rod1.frame = CGRect(x: tfHeight * 1.1 , y: 0,
                            width: tfHeight * 0.2 , height: tfCenterY - tfHeight * 0.75)
        
        rod2.frame = CGRect(x: screenWidth / 2 - tfHeight * 1.3, y: 0,
                            width: tfHeight * 0.2 , height: tfCenterY - tfHeight * 0.75)
        
        backboard.frame = CGRect(x: (screenWidth * 0.25 ) - (tfWidth / 2), y: tfCenterY - tfHeight * 0.75,
                                 width: tfWidth, height: tfHeight * 2.5)
        
        titleLabel.frame = CGRect(x: tfWidth * 0.075, y: tfHeight / 4,
                                  width: tfWidth * 0.85, height: tfHeight * 2)
        
        
        screw1.frame = CGRect(x: tfHeight * 0.1 , y: tfHeight * 0.1,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw2.frame = CGRect(x: tfWidth * 0.85 - tfHeight * 0.3 , y: tfHeight * 0.1,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw3.frame = CGRect(x: tfHeight * 0.1 , y: tfHeight * 2 - tfHeight * 0.3,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw4.frame = CGRect(x: tfWidth * 0.85 - tfHeight * 0.3 , y: tfHeight * 2 - tfHeight * 0.3,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        [screw1, screw2, screw3, screw4].forEach { $0.layer.cornerRadius = tfHeight * 0.1 }
        
        signInLabel.frame = CGRect(x: tfCenterX, y: tfCenterY -  screenHeight * 0.24,
                                   width: tfWidth, height: tfHeight)
        
        emailTextField.frame = CGRect(x: tfCenterX, y: tfCenterY -  screenHeight * 0.12,
                                      width: tfWidth, height: tfHeight)
        
        passwordTextField.frame = CGRect(x: tfCenterX, y: tfCenterY,
                                         width: tfWidth, height: tfHeight)
        
        signInButton.frame = CGRect(x: tfCenterX, y: tfCenterY + screenHeight * 0.12,
                                    width: tfWidth, height: tfHeight)
        
        signUpButton.frame = CGRect(x: tfCenterX, y: screenHeight - (tfHeight * 1.15),
                                    width: tfWidth, height: tfHeight)
        
        processingIndicator.frame = CGRect(x: (tfWidth / 2) - tfHeight * 0.375 , y: tfHeight * 0.125,
                                           width: tfHeight * 0.75, height: tfHeight * 0.75)
        
        
    }
    
    private func createPadPortraitLayout(screenHeight: CGFloat, screenWidth: CGFloat) {
        
        let tfWidth = screenWidth * 0.60
        let tfHeight = screenWidth /  10
        let tfCenterX = (screenWidth / 2) - (tfWidth / 2)
        
        //Text Size
        
        changeTextSizes(tfHeight: tfHeight)
        
        //View Size
        
        rod1.frame = CGRect(x: tfHeight * 2.8, y: 0,
                            width: tfHeight * 0.2 , height: tfHeight * 1.5)
        
        rod2.frame = CGRect(x: screenWidth - tfHeight * 3, y: 0,
                            width: tfHeight * 0.2 , height: tfHeight * 1.5)
        
        backboard.frame = CGRect(x: tfCenterX, y: tfHeight * 1.5,
                                 width: tfWidth, height: tfHeight * 2.5)
        
        titleLabel.frame = CGRect(x: tfWidth * 0.075, y: tfHeight / 4,
                                  width: tfWidth * 0.85, height: tfHeight * 2)
        
        screw1.frame = CGRect(x: tfHeight * 0.1 , y: tfHeight * 0.1,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw2.frame = CGRect(x: tfWidth * 0.85 - tfHeight * 0.3 , y: tfHeight * 0.1,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw3.frame = CGRect(x: tfHeight * 0.1 , y: tfHeight * 2 - tfHeight * 0.3,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        screw4.frame = CGRect(x: tfWidth * 0.85 - tfHeight * 0.3 , y: tfHeight * 2 - tfHeight * 0.3,
                              width: tfHeight / 5, height: tfHeight / 5)
        
        [screw1, screw2, screw3, screw4]
            .forEach { $0.layer.cornerRadius = tfHeight * 0.1 }
        
        signInLabel.frame = CGRect(x: tfCenterX, y: screenWidth * 0.55,
                                   width: tfWidth, height: tfHeight)
        
        emailTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 0.67,
                                      width: tfWidth, height: tfHeight)
        
        passwordTextField.frame = CGRect(x: tfCenterX, y: screenWidth * 0.79,
                                         width: tfWidth, height: tfHeight)
        
        signInButton.frame = CGRect(x: tfCenterX, y: screenWidth * 0.91,
                                    width: tfWidth, height: tfHeight)
        
        signUpButton.frame = CGRect(x: tfCenterX, y: screenHeight - (tfHeight * 1.15),
                                    width: tfWidth, height: tfHeight)
        
        processingIndicator.frame = CGRect(x: (tfWidth / 2) - tfHeight * 0.375 , y: tfHeight * 0.125,
                                           width: tfHeight * 0.75, height: tfHeight * 0.75)
        
    }
    
}

//Text Size Calculations

extension LoginViewController {
    
    private func changeTextSizes(tfHeight: CGFloat) {
        
        titleLabel.font = titleLabel.font.withSize(tfHeight * 1.25)
        
        signInLabel.font = signInLabel.font.withSize(tfHeight * 0.6125)
        
        emailTextField.font = emailTextField.font?.withSize(tfHeight * 0.3125 )
        
        passwordTextField.font = passwordTextField.font?.withSize(tfHeight * 0.3125 )
        
        signInButton.titleLabel?.font = signInButton.titleLabel?.font.withSize(tfHeight * 0.375)
        
        signUpButton.titleLabel?.font = signUpButton.titleLabel?.font.withSize(tfHeight * 0.125)
    
    }
    
}

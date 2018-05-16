//
//  AddPhotoConstants.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/4/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum AddPhotoConstants {
    
    enum Titles: String {
        case rightBarButton = "Next"
        case leftBarButton = "Cancel"
        case backButton = "Back"
        case navBar = "Select Photo"
    }
    
    enum CellNames: String {
        case addPhotoCell
        case addPhotoHeader
    }
    
    enum CoordinatorInfoKeys: String {
        case image
    }
    
}

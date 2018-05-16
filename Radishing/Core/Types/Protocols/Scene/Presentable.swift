//
//  Presentable.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol PresenterSetupable: Presentable, StaticViewControllerInjectable {
}

protocol Presentable {
    
    static func fetchResults(_ results: Results)
    
}

//
//  Alertable.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/12/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol Alertable: Servicable {
    
    static func processError(_ error: Error, completion: @escaping (AlertTitle, AlertMessage) -> Void)
    
}

//
//  ProfileProducer.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum ProfileProducer: AuthProducerSetupable {
    
    static var authenticator: Authenticatable.Type?
    
    static var presenter: Presentable.Type?
    
    static func fetchWork(_ work: Work) {
        self.authenticator = CurrentServices.authenticator
    }
    
}

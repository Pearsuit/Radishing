//
//  NotifiableProtocol.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/12/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol Notifiable: Servicable {
    
    func authorize(completion: @escaping () -> Void)
    
    func configure()
    
}

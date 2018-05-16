//
//  DatabaseWorkerableProtocol.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/9/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol DatabaseWorkerable: Codable {
    var reference: DatabaseReference { get }
    var id: String? { get set }
}

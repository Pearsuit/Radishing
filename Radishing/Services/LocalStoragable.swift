//
//  LocalStoragable.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/30/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol LocalStoragable {
    
    static func save(value: Any, key: String, completion: @escaping () -> Void)
    
    static func retrieve(for key: String) -> Any?
    
    static func delete(for key: String)
    
}

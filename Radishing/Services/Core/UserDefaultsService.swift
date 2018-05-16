//
//  UserDefaultsService.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/30/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum UserDefaultsService: LocalStoragable {
    
    static func save(value: Any, key: String, completion: @escaping () -> Void) {
        
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
        
        completion()
        
    }
    
    static func retrieve(for key: String) -> Any? {
        
        guard let value = UserDefaults.standard.object(forKey: key) else {
            return nil
        }
        
        return value
        
    }
    
    static func delete(for key: String) {
        
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
        
    }
    
}

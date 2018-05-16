//
//  EncodableExtension.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/10/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

extension Encodable {
    
    func toJSON(excluding keys: [String] = [String]()) throws -> [String : Any] {
        
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String : Any] else { throw EncodableError.encodingError }
        
        for key in keys {
            json[key] = nil
        }
        
        return json
    }
    
    func toJSON(including keys: [String] = [String]()) throws -> [String : Any] {
        
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String : Any] else { throw EncodableError.encodingError }
        
        for key in json.keys {
            if !keys.contains(key) { json[key] = nil }
        }
        
        return json
    }
    
}

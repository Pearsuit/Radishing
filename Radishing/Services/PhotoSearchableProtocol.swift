//
//  PhotoSearchableProtocol.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/4/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol PhotoSearchable {
    
    func searchByPhrase(phrase: String, completion: @escaping (_ imageData: Data?, _ error: Error?) -> Void)
    
}

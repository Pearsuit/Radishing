//
//  DatabasableProtocol.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/11/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol Databasable: Servicable {
    
    static func configure()
    
    static var create: Creatable.Type { get }
    
    static var read: Readable.Type { get }
    
    static func update<T: DatabaseWorkerable>(for object: T, with newInfoForKeys: [String], completion: @escaping () -> Void)
    
    static func delete<T: DatabaseWorkerable>(for object: T, completion: @escaping () -> Void)
    
    static func deleteChild<T: DatabaseWorkerable>(for object: T, childCollectionID: String, parentDocumentID: String, hasPhoto: Bool, completion: @escaping (Error?) -> Void)
    
    static func timeStamp() -> Date
    
    static func creationTransaction<T: DatabaseWorkerable>(for documentID: String, in collectionObject: T, updatingNumberFor: String, subCollectionID: String, subDocumentData: [String: Any], completion: @escaping (Error?)-> Void)
    
    static func deletionTransaction(completion: @escaping () -> Void)
    
    
}

protocol Creatable: Servicable {
    
    static func autoID<T: DatabaseWorkerable>(for encodableObject: T, completion: @escaping () -> Void)
    
    static func customIDForChild<T: DatabaseWorkerable>(_ parentDocumentID: String, childCollectionID: String, childDocumentID: String, for encodableObject: T, completion: @escaping () -> Void)
    
    static func customID<T: DatabaseWorkerable>(_ documentID: String, for encodableObject: T, completion: @escaping (T?) -> Void)
}

protocol Readable: Servicable {
    
    static func listen<T: DatabaseWorkerable>(from collectionID: DatabaseReference, returning objectType: T.Type, completion: @escaping ([T]) -> Void)
    
    static func unlisten(collectionID: DatabaseReference, completion: @escaping () -> Void)
    
    static func fetch<T: DatabaseWorkerable>(collectionID: DatabaseReference, documentID: String, objectType: T.Type, completion: @escaping (T?) -> Void)
    
    static func fetchChildren<T: DatabaseWorkerable>(parentCollectionID: DatabaseReference, parentDocumentID: String, childCollectionID: String, objectType: T.Type, completion: @escaping ([T]?) -> Void)
    
     static func fetchChild<T: DatabaseWorkerable>(parentCollectionID: DatabaseReference, parentDocumentID: String, childCollectionID: String, childDocumentID: String, objectType: T.Type, completion: @escaping (T?) -> Void)
    
    
    static func query<T: DatabaseWorkerable>(from collectionID: DatabaseReference, returning objectType: T.Type, where field: String, contains value: Any, completion: @escaping ([T]) -> Void)
    
}

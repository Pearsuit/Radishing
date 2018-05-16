//
//  FirestoreWorker.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/9/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import Firebase

var timestamp = FieldValue.serverTimestamp() // how to create a timestamp

enum FirestoreService: Databasable {
    
    private static func reference(to collectionID: DatabaseReference) -> CollectionReference {
        return Firestore.firestore().collection(collectionID.string)
    }
    private static func value(to key: ExcludedKeys) -> String {
        return key.string
    }
    
    static func configure() {
        FirebaseApp.configure()
    }
    
    //MARK: Create
    
    static let create: Creatable.Type = Creator.self
    
    private enum Creator: Creatable {
        
        static func autoID<T: DatabaseWorkerable>(for encodableObject: T, completion: @escaping () -> Void) {
            
            do {
                let json = try encodableObject.toJSON(excluding: [value(to: .id), value(to: .reference)])
                reference(to: encodableObject.reference).addDocument(data: json) { (error) in
                    guard error == nil else {
                        print("Error adding document: \(error!.localizedDescription)")
                        return
                    }
                    print("Document added")
                    completion()
                }
            } catch {
                print(error)
            }
            
        }
        
        static func customID<T: DatabaseWorkerable>(_ documentID: String, for encodableObject: T, completion: @escaping (T?) -> Void) {
            
            do {
                let json = try encodableObject.toJSON(excluding: [value(to: .id), value(to: .reference)])
                reference(to: encodableObject.reference).document(documentID).setData(json) { (error) in
                    guard error == nil else {
                        print("Error adding document: \(error!.localizedDescription)")
                        completion(nil)
                        return
                    }
                    print("Document added")
                    completion(encodableObject)
                }
            } catch {
                print(error)
            }
            
        }
        
        static func customIDForChild<T: DatabaseWorkerable>(_ parentDocumentID: String, childCollectionID: String, childDocumentID: String, for encodableObject: T, completion: @escaping () -> Void) {
            
            do {
                let json = try encodableObject.toJSON(excluding: [value(to: .id), value(to: .reference)])
                
                reference(to: encodableObject.reference).document(parentDocumentID).collection(childCollectionID).document(childDocumentID).setData(json) { (error) in
                    guard error == nil else {
                        print("Error adding document: \(error!.localizedDescription)")
                        return
                    }
                    print("Document added")
                    completion()
                }
            } catch {
                print(error)
            }
            
        }
        
        
    }
    
    //MARK: Read
    
    static let read: Readable.Type = Reader.self
    
    private enum Reader: Readable {
        
        static func listen<T: DatabaseWorkerable>(from collectionID: DatabaseReference, returning objectType: T.Type, completion: @escaping ([T]) -> Void) {
            
            reference(to: collectionID).addSnapshotListener { (snapshot, error) in
                guard error == nil else { return }
                guard let snapshot = snapshot else { return }
                
                do {
                    var objects = [T]()
                    for document in snapshot.documents {
                        let object = try document.decode(as: objectType)
                        objects.append(object)
                    }
                    
                    completion(objects)
                } catch {
                    print(error)
                }
                
            }
            
        }
        
        static func unlisten(collectionID: DatabaseReference, completion: @escaping () -> Void) {
            
        }
        
        static func fetch<T: DatabaseWorkerable>(collectionID: DatabaseReference, documentID: String, objectType: T.Type, completion: @escaping (T?) -> Void) {
            
            reference(to: collectionID).document(documentID).getDocument { (snapshot, error) in
                if let document = snapshot {
                    do {
                        let object = try document.decode(as: objectType)
                        completion(object)
                    } catch {
                        print(error)
                    }
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            }
        }
        
        static func listenToChildren<T: DatabaseWorkerable>(from collectionID: DatabaseReference, returning objectType: T.Type, completion: @escaping ([T]) -> Void) {
            
            reference(to: collectionID).addSnapshotListener { (snapshot, error) in
                guard error == nil else { return }
                guard let snapshot = snapshot else { return }
                
                do {
                    var objects = [T]()
                    for document in snapshot.documents {
                        let object = try document.decode(as: objectType)
                        objects.append(object)
                    }
                    
                    completion(objects)
                } catch {
                    print(error)
                }
                
            }
            
        }
        
        static func fetchChildren<T: DatabaseWorkerable>(parentCollectionID: DatabaseReference, parentDocumentID: String, childCollectionID: String, objectType: T.Type, completion: @escaping ([T]?) -> Void) {
            
            reference(to: parentCollectionID).document(parentDocumentID).collection(childCollectionID).getDocuments { (snapshot, error) in
                
                var objects: [T] = [T]()
                
                guard let documents = snapshot, error == nil else { return }
                
                for document in documents.documents {
                    print("This is a recipe: \(document.data())")
                    
                    do {
                        let object = try document.decode(as: objectType)
                        objects.append(object)
                    } catch {
                        print(error)
                    }
                    
                }
                
                objects.isEmpty ? completion(nil) : completion(objects)
                
            }
            
        }
        
        static func fetchChild<T: DatabaseWorkerable>(parentCollectionID: DatabaseReference, parentDocumentID: String, childCollectionID: String, childDocumentID: String, objectType: T.Type, completion: @escaping (T?) -> Void) {
            
            reference(to: parentCollectionID).document(parentDocumentID).collection(parentDocumentID).document(childDocumentID).getDocument { (snapshot, error) in
                if let document = snapshot {
                    do {
                        let object = try document.decode(as: objectType)
                        completion(object)
                    } catch {
                        print(error)
                    }
                } else {
                    print("Document does not exist")
                    completion(nil)
                }
            }
            
            
        }
        
        static func query<T: DatabaseWorkerable>(from collectionID: DatabaseReference, returning objectType: T.Type, where field: String, contains value: Any, completion: @escaping ([T]) -> Void) {
            
            reference(to: collectionID).whereField(field, isEqualTo: value).addSnapshotListener { (snapshot, error) in
                guard error == nil else { return }
                guard let snapshot = snapshot else { return }
                
                do {
                    var objects = [T]()
                    for document in snapshot.documents {
                        let object = try document.decode(as: objectType)
                        objects.append(object)
                    }
                    
                    completion(objects)
                } catch {
                    print(error)
                }
                
            }
            
        }
        
    }
    
    //MARK: Update
    
    static func update<T: DatabaseWorkerable>(for object: T, with newInfoForKeys: [String], completion: @escaping () -> Void) {
        
        do {
            let json = try object.toJSON(including: newInfoForKeys)
            guard let id = object.id else {
                throw EncodableError.encodingError
            }
            
            reference(to: object.reference).document(id).setData(json, options: .merge())
            
            completion()
            
        } catch {
            print(error)
        }
        
    }
    
    //MARK: Delete
    
    static func delete<T: DatabaseWorkerable>(for object: T, completion: @escaping () -> Void) {
        guard let id = object.id else { return }
        reference(to: object.reference).document(id).delete()
        completion()
    }
    
    static func deleteChild<T: DatabaseWorkerable>(for object: T, childCollectionID: String, parentDocumentID: String, hasPhoto: Bool, completion: @escaping (Error?) -> Void) {
        
        guard let id = object.id else { return }
        
        if hasPhoto {
            
            let parentFolderString = object.reference.string.capitalized
            
            CurrentServices.offlineStorage.deleteChildFolderData(parentFolder: parentFolderString, childFolder: parentDocumentID, filename: id) { error in
                if error == nil {
                    reference(to: object.reference).document(parentDocumentID).collection(childCollectionID).document(id).delete()
                    completion(nil)
                } else {
                    completion(error)
                }
            }
            
        } else {
            
            reference(to: object.reference).document(parentDocumentID).collection(childCollectionID).document(id).delete()
            completion(nil)
            
        }
        
    }
    
    
    static func timeStamp() -> Date {
        let timeStamp = FieldValue.serverTimestamp()
        return Date()
    }
    
    //MARK: Transactions
    
    static func creationTransaction<T: DatabaseWorkerable>(for documentID: String, in collectionObject: T, updatingNumberFor: String, subCollectionID: String, subDocumentData: [String: Any], completion: @escaping (Error?)-> Void) {
        
        Firestore.firestore().runTransaction({ (transaction, errorPointer) -> Any? in
            
            let document: DocumentSnapshot
            
            do {
                try document = transaction.getDocument(reference(to: collectionObject.reference).document(documentID))
            } catch {
                print(error)
                return nil
            }
            
            guard let oldData = document.data()?[updatingNumberFor] as? Int else { return nil }
            
            transaction.updateData([updatingNumberFor : oldData + 1], forDocument: reference(to: collectionObject.reference).document(documentID))
            
            let newSubDocument = reference(to: collectionObject.reference).document(documentID).collection(subCollectionID).document()
            
            transaction.setData(subDocumentData, forDocument: newSubDocument)
            
            completion(nil)
            return nil
        }) { (object, error) in
            
            completion(error)
            
        }
        
        
    }
    
    static func deletionTransaction(completion: @escaping () -> Void) {
        
    }
    
}

enum DocumentSnapshotError: Error {
    case noDataError
}

extension DocumentSnapshot {
    func decode<T: DatabaseWorkerable>(as objectType: T.Type, includingID: Bool = true) throws -> T {
        guard data() != nil else {
            throw DocumentSnapshotError.noDataError
        }
        
        var documentJSON = data()!
        if includingID {
            documentJSON["id"] = documentID
        }
        
        documentJSON["reference"] = createReference(with: objectType).string
        
        print(documentJSON)
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJSON, options: [])
        let decodeObject = try JSONDecoder().decode(objectType, from: documentData)
        return decodeObject
        
    }
}

private func createReference<T: DatabaseWorkerable>(with reference: T.Type) -> DatabaseReference {
    switch reference {
    case is User.Type : return .users
    case is Recipe.Type: return .recipes
    default: fatalError("Please add a new create reference to the switch statement")
    }
}

protocol DatabaseListenable: ListenerRegistration {
    func remove()
}

extension DatabaseListenable {
    func remove() {
        self.remove()
    }
}

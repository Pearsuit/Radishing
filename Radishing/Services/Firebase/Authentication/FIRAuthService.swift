//
//  FIRAuthWorker.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/11/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import FirebaseAuth

enum FIRAuthService: Authenticatable {
    
    static func createPhoneAuth(completion: @escaping () -> Void) throws {
        
        //Not implemented yet
        
        completion()
    
    }
    
    static func phoneLogin(completion: @escaping () -> Void) throws {
        
        //not implemented yet
        
        var authError: AuthError?

        if let authError = authError { throw authError }
        
        completion()
        
    }
    
    static func createEmailAuth(email: String, username: String, password: String, data: Data?, completion: @escaping (AuthError?, User?) -> Void){
        
        checkIfEmailIsRegistered(email: email) { (error, isRegistered) in
            
            guard error == nil else {
                if error!.localizedDescription.contains("connection") {
                    completion(AuthError.noInternetConnection, nil)
                } else if error!.localizedDescription.contains("email address") {
                    completion(AuthError.emailIsNotProperlyFormatted, nil)
                } else {
                    completion(AuthError.unknownError, nil)
                }
                return
            }
            
            if !isRegistered {
                
                processEmailSignUpRequest(email: email, username: username, password: password, data: data) { (error, user) in
                    completion(error, user)
                }
                
            } else {
                completion(AuthError.emailAlreadyInUse, nil)
            }
            
            
        }
    }
    
    private static func processEmailSignUpRequest(email: String, username: String, password: String, data: Data?, completion: @escaping (AuthError?, User?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            guard error == nil else {
                print(error?.localizedDescription)
                let authError = AuthError.emailIsNotProperlyFormatted
                completion(authError, nil)
                return
            }
            
            let changeRequest = user?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let _ = error {
                    let authError = AuthError.displayNameCreationError
                    completion(authError, nil)
                    return
                }
                
                guard let userID = user?.uid else { return }
                
                CurrentServices.database.create.customID(userID, for: User(reference: .users, id: userID, photoURL: nil) ){ user in
                    if user == nil {
                        Auth.auth().currentUser?.delete(completion: { (error) in
                            if let _ = error {
                                let error = AuthError.couldNotDeleteFailedUserCreation
                                completion(error, nil)
                            } else {
                                completion(nil, nil)
                            }
                            
                        })
                    } else if let imageData = data {
                        CurrentServices.offlineStorage.uploadData(folder: "profile_images", filename: userID, data: imageData) { storageURL in
                            print("17. uploaded data and got storage url")
                            CurrentServices.database.update(for: User(reference: .users, id: userID, photoURL: storageURL), with: ["photoURL"], completion: {
                                print("18. added storage url to user")
                                
                                let userDictionary: [String : Any?] = ["photoURL" : storageURL]
                                
                                CurrentServices.localStorage.save(value: userDictionary, key: "user") {
                                    print("19. added photo url to user defaults")
                                    completion(nil, User(reference: .users, id: userID, photoURL: storageURL))
                                    
                                }
                            })
                        }
                    } else {
                        let userDictionary = [String : Any]()
                        CurrentServices.localStorage.save(value: userDictionary, key: "user", completion: {
                            completion(nil, user)
                        })
                    }
                }
                
            })
            
        }
    }
    
    
    
    
    static func emailLogin(email: String, password: String, completion: @escaping (Error?, User?) -> Void) {
        
        print("Processing email login")
        
        checkIfEmailIsRegistered(email: email) { (error, isRegistered) in
            
            guard error == nil else {
                print("Error has occurred while checking if email is registered: \(error!.localizedDescription)")
                if error!.localizedDescription.contains("connection") {
                    completion(AuthError.noInternetConnection, nil)
                } else if error!.localizedDescription.contains("email address") {
                    completion(AuthError.emailIsNotProperlyFormatted, nil)
                } else {
                    completion(AuthError.unknownError, nil)
                }
                return
            }
            
            if isRegistered {
                print("Email is registered")
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if let _ = error {
                        completion(AuthError.emailLoginUnsuccessful, nil)
                    } else {
                        
                        let uid = user!.uid
                        
                        CurrentServices.database.read.fetch(collectionID: .users, documentID: uid, objectType: User.self, completion: { (user) in
                            
                            guard let user = user else { return }
                            
                            do {
                                let userDictionary = try user.toJSON(excluding: ["id", "reference"])
                                
                                CurrentServices.localStorage.save(value: userDictionary, key: "user", completion: {
                                    completion(nil, user)
                                })
                                
                            } catch {
                                print("This is not usable for a user")
                            }
                            
                            
                        })
                    }
                }
                
            } else {
                print("Email is not registered")
                completion(AuthError.emailIsNotRegistered, nil)
                
            }
            
        }
        
    }
    
    private static func checkIfEmailIsRegistered(email: String, completion: @escaping (Error?, Bool) -> Void) {
        
        Auth.auth().fetchProviders(forEmail: email) { (providers, error) in
            
            guard error == nil else {
                completion(error!, false)
                return
            }
            
            if let _ = providers {
                completion(nil, true)
            } else {
                completion(nil, false)
            }
            
        }
        
    }
    
    static func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            CurrentServices.localStorage.delete(for: "user")
            completion(nil)
        } catch {
            completion(AuthError.signOutUnsuccessful)
        }
    }
    
    static func fetchDisplayName(completion: @escaping (String) -> Void) {
        let displayName = Auth.auth().currentUser?.displayName ?? "Profile"
        completion(displayName)
    }
    
    static func loggedInUserID() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
}

//IGNORE EVERYTHING PASSED THIS LINE: The is a WIP that will be implemented at a later date

protocol AuthListenerable: AuthStateDidChangeListenerHandle {
    func instantiate() -> AuthStateDidChangeListenerHandle
    func remove()
}

extension AuthListenerable {
    func instantiate(viewController: UIViewController) -> AuthStateDidChangeListenerHandle {
        let handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == nil {
                viewController.present(RegistrationViewController(), animated: true, completion: nil)
            }
        }
        return handle
        
    }
    func remove() {
        self.remove()
    }
}

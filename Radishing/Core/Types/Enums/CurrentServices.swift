//
//  CurrentServices.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

//Due to global access, only store services that contain only functions and no mutable properties inside the enum. Services that contain mutable properties must be dependency injected so as to prevent undesired and or uncontrollable behavior.

enum CurrentServices {
    
    static let database: Databasable.Type = FirestoreService.self
    
    static let notifier: Notifiable = FIRNotificationService.shared
    
    static let authenticator: Authenticatable.Type = FIRAuthService.self
    
    static let offlineStorage: OfflineStoragable.Type = FIRStorageService.self
    
    static let photoRetriever: PhotoRetrievable.Type = PhotoRetrievalService.self
    
    static let localStorage: LocalStoragable.Type = UserDefaultsService.self
    
    static let photoSearcher: PhotoSearchable = FlickrAPI.shared
    
}

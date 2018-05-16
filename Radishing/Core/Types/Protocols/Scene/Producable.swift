//
//  Producable.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

protocol ProducerSetupable: Producable, StaticPresenterInjectable {
}

protocol Producable {
    
    static func fetchWork(_ work: Work)
    
}

protocol AuthProducerSetupable: ProducerSetupable {
    
    static var authenticator: Authenticatable.Type! { get set }
    
}

protocol OfflineStorageProducerSetupable: ProducerSetupable {
    
    static var offlineStorage: OfflineStoragable.Type! { get set }
    
}

protocol NotificationProducerSetupable: ProducerSetupable {
    
    static var notifier: Notifiable.Type! { get set }
    
}

protocol DatabaseProducerSetupable: ProducerSetupable {
    
    static var database: Databasable.Type! { get set }
    
}

protocol PhotoRetrieverProducerSetupable: ProducerSetupable {
    
    static var photoRetriever: PhotoRetrievable.Type! { get set }
    
}

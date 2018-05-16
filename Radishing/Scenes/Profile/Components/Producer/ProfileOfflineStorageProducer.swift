//
//  ProfileOfflineStorageProducer.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

enum ProfileOfflineStorageProducer: OfflineStorageProducerSetupable {
    static var offlineStorage: OfflineStoragable.Type!
    static var presenter: Presentable.Type!
    
    static func fetchWork(_ work: Work) {
        self.offlineStorage = CurrentServices.offlineStorage
        self.presenter = work.presenter
        let assignment = work.assignment as! OfflineStorageAssignment
        switch assignment {
        case .fetchData:
            let photoFetch = work.model as! PhotoFetch
            offlineStorage?.fetchData(url: photoFetch.storageURL, completion: { (data, error) in
                let photoData = PhotoData(data: data)
                let results = Results(assignment: OfflineStorageAssignment.fetchData, error: error, model: photoData)
                presenter.fetchResults(results)
            })
        default: print("Error at producer")
        }
    }
}

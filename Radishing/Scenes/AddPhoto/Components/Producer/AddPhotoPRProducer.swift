//
//  AddPhotoPRProducer.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation
import Photos

enum AddPhotoPRProducer: PhotoRetrieverProducerSetupable {
    
    static var photoRetriever: PhotoRetrievable.Type!
    static var presenter: Presentable.Type!
    
    static func fetchWork(_ work: Work) {
        presenter = work.presenter
        photoRetriever = CurrentServices.photoRetriever
        let assignment = work.assignment as! PhotoRetrievalAssignment
        switch assignment {
        case .fetchPhotos:
            handleFetchPhotos()
        case .fetchBetterQualityPhoto:
            let asset = work.model as! PHAsset
            handleFetchBetterQualityPhoto(asset: asset)
        }
    }
    
    private static func handleFetchPhotos() {
        photoRetriever?.fetchLowQualityPhotos(completion: { (imagesArray, assetsArray) in
            let info = PhotosAndAssets(photos: imagesArray, assets: assetsArray)
            let results = Results(assignment: PhotoRetrievalAssignment.fetchPhotos, error: nil, model: info)
            presenter?.fetchResults(results)
        })
    }
    
    private static func handleFetchBetterQualityPhoto(asset: PHAsset) {
        photoRetriever.fetchBetterQualitySinglePhoto(asset: asset) { (image) in
            let results = Results (assignment: PhotoRetrievalAssignment.fetchBetterQualityPhoto, error: nil, model: image)
            presenter?.fetchResults(results)
        }
    }
}

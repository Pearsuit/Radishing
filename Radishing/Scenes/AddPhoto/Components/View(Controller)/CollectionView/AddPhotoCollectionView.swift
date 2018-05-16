//
//  AddPhotoCollectionView.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension AddPhotoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = photosArray[indexPath.row]
        selectedImageDisplayDelegate?.displaySelectedImage(selectedImage)
        selectedPhotoImageView.image = selectedImage
        
        let selectedAsset = assetsArray[indexPath.row]
        let request = Request(assignment: PhotoRetrievalAssignment.fetchBetterQualityPhoto, model: selectedAsset)
        allocator.fetchRequest(request)
        
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .bottom, animated: true)
    }
}

extension AddPhotoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPhotoConstants.CellNames.addPhotoCell.string, for: indexPath) as! AddPhotoCell
        cell.image = photosArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddPhotoConstants.CellNames.addPhotoHeader.string, for: indexPath) as! AddPhotoHeader
        selectedImageDisplayDelegate = header
        
        selectedImageDisplayDelegate?.displaySelectedImage(photosArray.first)
        selectedPhotoImageView.image = photosArray.first
        
        if let selectedAsset = assetsArray.first {
            let request = Request(assignment: PhotoRetrievalAssignment.fetchBetterQualityPhoto, model: selectedAsset)
            allocator.fetchRequest(request)
        }

        return header
    }
}

extension AddPhotoViewController: UICollectionViewDelegateFlowLayout {
}

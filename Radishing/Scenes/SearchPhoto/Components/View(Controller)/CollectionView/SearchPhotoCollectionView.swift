//
//  SearchPhotoCollectionView.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension SearchPhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SearchPhotoCell
        let image = cell.image!
        let info = [SearchPhotoConstants.CoordinatorInfoKeys.image.string : image]
        coordinator.transition(.createRecipe, with: info)
    }
}

extension SearchPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchPhotoConstants.CellNames.searchPhotoCell.string, for: indexPath) as! SearchPhotoCell
        cell.image = imagesArray[indexPath.row]
        
        if indexPath == selectedImageIndexPath {
            cell.changePhotoAlpha(0.3)
        } else {
            cell.changePhotoAlpha(1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
}

extension SearchPhotoViewController: UICollectionViewDelegateFlowLayout {
}

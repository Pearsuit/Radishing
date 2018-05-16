//
//  ProfileCollectionView.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let image = (collectionView.cellForItem(at: indexPath) as! RecipeCell).photoImageView.image else { return }
        guard let user = currentUser else { return }
        
        let viewController = ViewRecipeViewController(recipe: userRecipes[indexPath.row], recipeImage: image, user: user, delegate: self, indexPath: indexPath)
        let navController = UINavigationController(rootViewController: viewController)
        present(navController, animated: true, completion: nil)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileConstants.CellNames.recipeCell.string, for: indexPath) as! RecipeCell
        cell.recipe = userRecipes[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userRecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileConstants.CellNames.profileHeader.string, for: indexPath) as! ProfileHeader
        header.layoutDelegate = self
        profileInfoDisplayDelegate = header
        return header
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
}

//
//  RecipeCell.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/1/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

class RecipeCell: UICollectionViewCell {
    
    //MARK: VARIABLES
    
    var recipe: Recipe! {
        // Quick solution. Fix at a later date so that the cell does not know about services.
        didSet {
            photoImageView.image = nil
            addSubview(activityIndicator)
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            CurrentServices.offlineStorage.fetchData(url: recipe.imageURL) { (data, error) in
                
                guard error == nil, let data = data, let image = UIImage(data: data) else {
                    DispatchQueue.main.sync { [unowned self] in
                        self.photoImageView.image = #imageLiteral(resourceName: "BlankProfileImage").withRenderingMode(.alwaysOriginal)
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.removeFromSuperview()
                    }
                    return
                }
                
                DispatchQueue.main.sync { [unowned self] in
                    self.photoImageView.image = image
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.removeFromSuperview()
                }
            }
        }
    }
    
    //MARK: UI VIEWS
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.isHidden = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = .appLightRed
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    //MARK: VIEW LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appOffWhite
        addSubview(photoImageView)
        conformLayoutToDisplay(size: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        super.willTransition(from: oldLayout, to: newLayout)
        let layout = newLayout as! UICollectionViewFlowLayout
        conformLayoutToDisplay(size: layout.itemSize)
    }
}


//
//  AddPhotoCell.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

class AddPhotoCell: UICollectionViewCell {
    
    //MARK: VARIABLES
    
    var image: UIImage! {
        didSet {
            configureCell()
        }
    }
    
    //MARK: UI VIEWS
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    //MARK: VIEW LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        addSubview(photoImageView)
        photoImageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        super.didTransition(from: oldLayout, to: newLayout)
        photoImageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width)
    }
    
    //MARK: OTHER CHILD FUNCTIONS
    
    private func configureCell() {
        photoImageView.image = image
    }
}


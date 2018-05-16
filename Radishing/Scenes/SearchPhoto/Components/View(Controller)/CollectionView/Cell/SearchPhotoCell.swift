//
//  SearchPhotoCell.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/6/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

class SearchPhotoCell: UICollectionViewCell {
    
    //MARK: VARIABLES
    
    var image: UIImage! {
        didSet {
            configureCell()
        }
    }
    
    //MARK: UI VIEWS
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //MARK: VIEW LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appOffWhite
        addSubview(imageView)
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
    
    //MARK: PROTOCOL-GIVEN FUNCTIONALITY
    
    func changePhotoAlpha(_ alpha: CGFloat) {
        imageView.alpha = alpha
    }
    
    //MARK: OTHER CHILD FUNCTIONS
    
    private func configureCell() {
        imageView.image = image
    }
}

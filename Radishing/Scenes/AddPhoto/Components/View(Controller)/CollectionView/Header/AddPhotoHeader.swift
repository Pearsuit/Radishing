//
//  AddPhotoHeader.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/26/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

class AddPhotoHeader: UICollectionViewCell, SelectedImageDisplayDelegate {
    
    //MARK: UI VIEWS
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    //MARK: VIEW LIFECYCLE
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .appBluishGray
        addSubview(photoImageView)
        photoImageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.width)
        conformLayoutToDisplay(size: frame.size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        super.willTransition(from: oldLayout, to: newLayout)
        let layout = newLayout as! UICollectionViewFlowLayout
        conformLayoutToDisplay(size: layout.headerReferenceSize)
    }
    
    //MARK: PROTOCOL-GIVEN FUNCTIONALITY
    
    func displaySelectedImage(_ image: UIImage?) {
        DispatchQueue.main.async { [unowned self] in
            self.photoImageView.image = image
        }
    }
    
    func sendImage() -> UIImage? {
        return photoImageView.image
    }
}

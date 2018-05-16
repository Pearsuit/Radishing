//
//  ProfileHeader.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/25/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

protocol ChangeLayoutDelegate {
    func changeToGridView()
    func changeToListView()
}

class ProfileHeader: UICollectionViewCell, ProfileInfoDisplayDelegate {
    
    //MARK: VARIABLES
    
    var layoutDelegate: ChangeLayoutDelegate?
    
    //MARK: UI VIEWS
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .appOffWhite
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let recipesLabel: UILabel = {
        let label = UILabel()
        label.text = ProfileConstants.Titles.recipes.string
        label.font = UIFont(name: AppFonts.fancy.string, size: 15)
        label.textAlignment = .center
        label.textColor = .appBluishGray
        return label
    }()
    
    let recipesCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont(name: AppFonts.fancy.string, size: 15)
        label.textAlignment = .center
        label.textColor = .appLightRed
        return label
    }()
    
    let buttonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .appPink
        return view
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "keypad"), for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        return button
    }()
    
    //MARK: VIEW LIFECYCLE
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [profileImageView, recipesLabel, recipesCountLabel, recipesCountLabel, buttonContainerView].forEach { addSubview($0)}
        
        [gridButton, listButton].forEach { buttonContainerView.addSubview($0) }
        
        conformLayoutToDisplay(size: frame.size)
        
        if profileImageView.image == nil {
            profileImageView.image = #imageLiteral(resourceName: "BlankProfileImage").withRenderingMode(.alwaysOriginal)
        }
        
        gridButton.addTarget(self, action: #selector(changeLayoutToGrid), for: .touchUpInside)
        listButton.addTarget(self, action: #selector(changeLayoutToList), for: .touchUpInside)
        
        backgroundColor = .appLightGreen
        
        changeLayoutToGrid(gridButton)
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
    
    func fetchInfo(view: ProfileView, info: Any) {
        switch view {
        case .displayName:
            let _ = info as! String
            //no current userlabel needed
        case .profilePhoto:
            let image = info as! UIImage
            DispatchQueue.main.sync {
                profileImageView.image = image
            }
        case .recipeCount:
            let count = info as! Int
            recipesCountLabel.text = "\(count)"
        }
    }
    
    //MARK: UI USER ACTIONS
    
    @objc private func changeLayoutToGrid(_ sender: UIButton) {
        gridButton.tintColor = .black
        listButton.tintColor = .appOffWhite
        layoutDelegate?.changeToGridView()
    }
    
    @objc private func changeLayoutToList(_ sender: UIButton) {
        listButton.tintColor = .black
        gridButton.tintColor = .appOffWhite
        layoutDelegate?.changeToListView()
    }
}

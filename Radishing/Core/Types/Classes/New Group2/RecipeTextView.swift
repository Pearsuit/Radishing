//
//  RecipeTextView.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/10/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

class RecipeTextView: UITextView {
    
    private let placeholder: UILabel = {
        
        let label = UILabel()
        label.text = "Write Recipe Here..."
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        return label
        
    }()
    
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholder)
        
        NotificationCenter.default.addObserver(self, selector: #selector(isPlaceholderVisible), name: .UITextViewTextDidChange, object: nil)
        
        //For information on custom operators, check the CustomOperators.swift file
        
        let placeholderConstraints = topConstraint(of: 8, equalTo: self.topAnchor)
                                        >>> leftConstraint(of: 4, equalTo: self.leftAnchor)
                                        >>> allowForCustomConstraints(true)
                                        >>> allowForCustomConstraints(true)

        
        let _ = placeholder |> placeholderConstraints
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func isPlaceholderVisible(_ sender: UITextView) {
        placeholder.isHidden = !text.isEmpty
    }
    
}

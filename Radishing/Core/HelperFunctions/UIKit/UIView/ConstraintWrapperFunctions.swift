//
//  ConstraintWrapperFunctions.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 5/10/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import UIKit

func allowForCustomConstraints<T: UIView>(_ bool: Bool) -> (T) -> T {
    return { view in
        view.translatesAutoresizingMaskIntoConstraints = !bool
        return view
    }
}

func topConstraint<T: UIView>(of value: CGFloat, equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>) -> (T) -> T {
    return { view in
        view.topAnchor.constraint(equalTo: equalTo, constant: value).isActive = true
        return view
    }
}

func bottomConstraint<T: UIView>(of value: CGFloat, equalTo: NSLayoutAnchor<NSLayoutYAxisAnchor>) -> (T) -> T {
    return { view in
        view.bottomAnchor.constraint(equalTo: equalTo, constant: value).isActive = true
        return view
    }
}

func leftConstraint<T: UIView>(of value: CGFloat, equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>) -> (T) -> T {
    return { view in
        view.leftAnchor.constraint(equalTo: equalTo, constant: value).isActive = true
        return view
    }
}

func rightConstraint<T: UIView>(of value: CGFloat, equalTo: NSLayoutAnchor<NSLayoutXAxisAnchor>) -> (T) -> T {
    return { view in
        view.rightAnchor.constraint(equalTo: equalTo, constant: value).isActive = true
        return view
    }
}

func heightConstraint<T: UIView>(of value: CGFloat) -> (T) -> T {
    return { view in
        view.heightAnchor.constraint(equalToConstant: value).isActive = true
        return view
    }
}
func widthConstraint<T: UIView>(of value: CGFloat) -> (T) -> T {
    return { view in
        view.widthAnchor.constraint(equalToConstant: value).isActive = true
        return view
    }
}

//
//  CustomOperators.swift
//  Radishing
//
//  Created by Nathaniel Dillinger on 4/19/18.
//  Copyright © 2018 Nathaniel Dillinger. All rights reserved.
//

import Foundation

/* Special Note : Unfortunately, the inital view of a controller does not allow chaining of custom operators with it directly. To chain functions with the initial view, you must save the function chain to a variable and use like Pipe operator:
 ex. var principleView = backgroundColor(.blue) >>> cornerRadius(of: 2)
 view |> principleView
 
 
 */
//MARK: Precdence Groups
precedencegroup ForwardApplication {
    associativity: left
}

precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardApplication
}

//MARK: Operators

//Pipe: Commonly found in languages like Elm, this operator takes in a value and returns a value. In mathematically terms, it produces an f(x)

infix operator |>: ForwardApplication

func |> <X, Y> (x: X, f: (X) -> Y) -> Y {
    return f(x)
}

//Composition: Commonly found in languages like Haskell, this operator takes in two functions, and turns a concatinated version. In mathematically terms, it produces a "g composes f" result. This allows for chaining of functions to be stored in a variable, ex. var myNewFunction = Double.init >>> sqrt >>> Int.init. When combined with the Pipe operator, it creates an g(f(x)) equation, ex. 2 |> Double.init >>> sqrt >>> Int.init

infix operator >>>: ForwardComposition

func >>> <X, Y, Z> (f: @escaping (X) -> Y, g: @escaping (Y) -> Z) -> (X) -> Z {
    
    return { x in
        g(f(x))
    }
    
}

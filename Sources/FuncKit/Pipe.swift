//
//  Pipe.swift
//  Work
//
//  Created by Jonathan McAllister on 01/02/2018.
//  Copyright © 2018 Jonathan McAlister. All rights reserved.
//

import Foundation

precedencegroup PipePrecedenceRight {
    associativity: right
    lowerThan: LogicalDisjunctionPrecedence
    higherThan: AssignmentPrecedence
}

// Pipe forward
infix operator |>: MonadicPrecedenceRight

public func |> <A, B>(a: A, f: @escaping (A) -> B) -> B {
    return f(a)
}

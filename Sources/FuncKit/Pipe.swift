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

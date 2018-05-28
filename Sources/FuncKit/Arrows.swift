import Foundation

precedencegroup AlternativePrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
    lowerThan: ComparisonPrecedence
}
precedencegroup ApplicativePrecedence {
    associativity: left
    higherThan: AlternativePrecedence
    lowerThan: NilCoalescingPrecedence
}
precedencegroup MonadicPrecedenceRight {
    associativity: right
    lowerThan: LogicalDisjunctionPrecedence
    higherThan: AssignmentPrecedence
}
precedencegroup MonadicPrecedenceLeft {
    associativity: left
    lowerThan: LogicalDisjunctionPrecedence
    higherThan: AssignmentPrecedence
}
precedencegroup CategoryPrecedence {
    associativity: right
    higherThan: MonadicPrecedenceRight
}
precedencegroup ArrowPrecedence {
    associativity: right
    higherThan: CategoryPrecedence
}
precedencegroup ArrowChoicePrecedence {
    associativity: right
    higherThan: ArrowPrecedence
}

/// Map
infix operator <^>: ApplicativePrecedence
/// Apply
infix operator <*>: ApplicativePrecedence
// Kleisli composition (Monadic)
infix operator >=>: MonadicPrecedenceRight
// Kleisli composition (Comonadic)
infix operator =>=: MonadicPrecedenceRight
// Extend
infix operator =>>: MonadicPrecedenceRight

/// Split | Splits two computations and combines the result into one Arrow yielding a tuple of
/// the result of each side.
infix operator *** : ArrowPrecedence

/// Fanout | Given two functions with the same source but different targets, this function
/// splits the computation and combines the result of each Arrow into a tuple of the result of
/// each side.
infix operator &&& : ArrowPrecedence

/// Right-to-Left Composition | Composes two categories to form a new category with the source of
/// the second category and the target of the first category.
///
/// This function is literally `•`, but for Categories.
infix operator <<< : MonadicPrecedenceLeft

/// Left-to-Right Composition | Composes two categories to form a new category with the source of
/// the first category and the target of the second category.
///
/// Function composition with the arguments flipped.
infix operator >>> : MonadicPrecedenceRight

/// Splat | Splits two computations and combines the results into Eithers on the left and right.
infix operator +++ : ArrowChoicePrecedence

/// Fanin | Given two functions with the same target but different sources, this function splits
/// the input between the two and merges the output.
infix operator ||| : ArrowChoicePrecedence

public func ||| <B, C, D>(f: @escaping (B) -> D, g: @escaping (C) -> D) -> ((Either<B, C>) -> D) {
    return { $0.either(onLeft: f, onRight: g) }
}

public func +++ <B, C, D, E>(f: @escaping (B) -> C, g: @escaping (D) -> E) -> ((Either<B, D>) -> Either<C, E>) {
    return (Either.left <<< f) ||| (Either.right <<< g)
}

public func <<< <A, B, C>(g: @escaping (B) -> C, f: @escaping (A) -> B) -> (A) -> C {
    return { g(f($0)) }
}

public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

public func *** <B, C, D, E>(f: @escaping (B) -> C, g: @escaping (D) -> E) -> ((B, D) -> (C, E)) {
    return { (f($0), g($1)) }
}

public func &&& <A, B, C>(f: @escaping (A) -> B, g: @escaping (A) -> C) -> ((A) -> (B, C)) {
//    return { ($0, $0) } >>> f *** g
    return split >>> f *** g
}

public func first<A, B, C>(_ f: @escaping (A) -> C) -> ((A, B) -> (C, B)) {
    return { (f($0), $1) }
}

public func second<A, B, C>(_ f: @escaping (B) -> C) -> ((A, B) -> (A, C)) {
    return { ($0, f($1)) }
}

public func split<A>(_ a: A) -> (A, A) {
    return (a, a)
}

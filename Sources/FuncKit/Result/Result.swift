import Foundation

public enum Result<Wrapped> {
    /// The presence of an error, stored as `Error`.
    case failure(Error)
    
    /// The presence of a value, stored as `Wrapped`.
    case success(Wrapped)
}

/// Functor
extension Result {
    /// Evaluates the given closure when this `Result` instance is not
    /// `failure`, passing the unwrapped value as a parameter.
    ///
    /// Use the `map` method with a closure that returns a non-Result value.
    ///
    /// - Parameter transform: A closure that takes the unwrapped value
    ///   of the instance.
    /// - Returns: The result of the given closure. If this instance is
    ///   `failure`, returns `failure`.
    @discardableResult public func map<U>(_ transform: (Wrapped) -> U) -> Result<U> {
        switch self {
        case let .success(value):
            return .success(transform(value))
        case let .failure(error):
            return .failure(error)
        }
    }
}

/// Monad
extension Result {
    
    public init(_ wrapped: Wrapped) {
        self = .success(wrapped)
    }
    
    // Evaluates the given closure when this `Result` instance is not `failure`,
    /// passing the unwrapped value as a parameter.
    ///
    /// Use the `flatMap` method with a closure that returns an Result value.
    ///
    /// - Parameter transform: A closure that takes the unwrapped value
    ///   of the instance.
    /// - Returns: The result of the given closure. If this instance is
    ///    `failure`, returns `failure`.
    @discardableResult public func flatMap<U>(_ transform: (Wrapped) -> Result<U>) -> Result<U> {
        return self.map(transform).join()
    }
    
    public func join<U>() -> Result<U> where Wrapped == Result<U> {
        switch self {
        case let .success(result):
            return result
        case let .failure(error):
            return .failure(error)
        }
    }
}

/// Applicative
extension Result {
    /// Applicative Functors provide the ability to operate on not just values,
    /// but values in a functorial context without needing to unwrap or map over
    /// their contents.
    public func apply<U>(_ f: Result<((Wrapped) -> U)>) -> Result<U> {
        return f.flatMap(self.map)
    }
}

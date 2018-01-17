import Foundation

// Failure-coalescing
public func ?? <T>(result: Result<T>, defaultValue: @autoclosure () -> T) -> T {
    return result.successValue ?? defaultValue()
}

// Failure-coalescing
public func ?? <T>(result: Result<T>, defaultValue: @autoclosure () -> Result<T>) -> Result<T> {
    switch result {
    case .success:
        return result
    case .failure:
        return defaultValue()
    }
}

// Map
public func <^> <T, U>(f: (T) -> U, a: Result<T>) -> Result<U> {
    return a.map(f)
}

// Flatmap/Bind
public func >>= <T1, T2>(left: Result<T1>, right: (T1) -> Result<T2>) -> Result<T2> {
    return left.flatMap(right)
}

// Kleisli composition
public func >=> <T1, T2, T3>(left: @escaping (T1) -> Result<T2>, right: @escaping (T2) -> Result<T3>) -> ((T1) -> Result<T3>) {
    return { left($0) >>= right }
}

// Applicative
public func <*> <T, U>(f: Result<((T) -> U)>, a: Result<T>) -> Result<U> {
    return a.apply(f)
}

import Foundation

// Map
public func <^> <T, U>(f: @escaping (T) -> U, a: Future<T>) -> Future<U> {
    return a.map(f)
}

// Flatmap/Bind
public func >>= <T1, T2>(left: Future<T1>, right: @escaping (T1) -> Future<T2>) -> Future<T2> {
    return left.flatMap(right)
}

// Applicative
public func <*> <T, U>(f: Future<((T) -> U)>, a: Future<T>) -> Future<U> {
    return a.apply(f)
}

// Composition
public func >=> <T1, T2, T3>(left: @escaping (T1) -> Future<T2>, right: @escaping (T2) -> Future<T3>) -> ((T1) -> Future<T3>) {
    return { left($0) >>= right }
}

prefix operator ⏱

extension Future {
    public static prefix func ⏱ (future:  Future) -> Result<Wrapped> {
        return await(future)
    }
}

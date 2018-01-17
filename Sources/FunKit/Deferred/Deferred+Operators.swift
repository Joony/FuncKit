import Foundation

// Map
public func <^> <A, B>(f: @escaping (A) -> B, a: Deferred<A>) -> Deferred<B> {
    return a.map(f)
}

// Flatmap/Bind
public func >>= <A, B>(left: Deferred<A>, right: @escaping (A) -> Deferred<B>) -> Deferred<B> {
    return left.flatMap(right)
}

// Apply
public func <*> <A, B>(f: Deferred<((A) -> B)>, a: Deferred<A>) -> Deferred<B> {
    return a.apply(f)
}

// Kleisli Composition
public func >=> <A, B, C>(left: @escaping (A) -> Deferred<B>, right: @escaping (B) -> Deferred<C>) -> ((A) -> Deferred<C>) {
    return { left($0) >>= right }
}

prefix operator ⏱

extension Deferred {
    public static prefix func ⏱ (deferred: Deferred) -> Wrapped {
        return await(deferred)
    }
}

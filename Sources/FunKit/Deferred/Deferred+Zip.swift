import Foundation

public func zip<A, B>(_ a: Deferred<A>, _ b: Deferred<B>) -> Deferred<(A, B)> {
    return lift2(toDeferred: { ($0, $1) })(a, b)
}
    
public func zip<A, B, C>(_ a: Deferred<A>, _ b: Deferred<B>, _ c: Deferred<C>) -> Deferred<(A, B, C)> {
    return lift3(toDeferred: { ($0, $1, $2) })(a, b, c)
}

public func zip<A, B, C, D>(_ a: Deferred<A>, _ b: Deferred<B>, _ c: Deferred<C>, _ d: Deferred<D>) -> Deferred<(A, B, C, D)> {
    return lift4(toDeferred: { ($0, $1, $2, $3) })(a, b, c, d)
}

public func zip<A, B, C, D, E>(_ a: Deferred<A>, _ b: Deferred<B>, _ c: Deferred<C>, _ d: Deferred<D>, _ e: Deferred<E>) -> Deferred<(A, B, C, D, E)> {
    return lift5(toDeferred: { ($0, $1, $2, $3, $4) })(a, b, c, d, e)
}

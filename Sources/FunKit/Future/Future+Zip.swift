import Foundation

public func zip<A, B>(_ a: Future<A>, _ b: Future<B>) -> Future<(A, B)> {
    return lift2(toFuture: { ($0, $1) })(a, b)
}

public func zip<A, B, C>(_ a: Future<A>, _ b: Future<B>, _ c: Future<C>) -> Future<(A, B, C)> {
    return lift3(toFuture: { ($0, $1, $2) })(a, b, c)
}

public func zip<A, B, C, D>(_ a: Future<A>, _ b: Future<B>, _ c: Future<C>, _ d: Future<D>) -> Future<(A, B, C, D)> {
    return lift4(toFuture: { ($0, $1, $2, $3) })(a, b, c, d)
}

public func zip<A, B, C, D, E>(_ a: Future<A>, _ b: Future<B>, _ c: Future<C>, _ d: Future<D>, _ e: Future<E>) -> Future<(A, B, C, D, E)> {
    return lift5(toFuture: { ($0, $1, $2, $3, $4) })(a, b, c, d, e)
}

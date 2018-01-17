import Foundation

public func zip<A, B>(_ a: Result<A>, _ b: Result<B>) -> Result<(A, B)> {
    return lift2(toResult: { ($0, $1) })(a, b)
}

public func zip<A, B, C>(_ a: Result<A>, _ b: Result<B>, _ c: Result<C>) -> Result<(A, B, C)> {
    return lift3(toResult: { ($0, $1, $2) })(a, b, c)
}

public func zip<A, B, C, D>(_ a: Result<A>, _ b: Result<B>, _ c: Result<C>, _ d: Result<D>) -> Result<(A, B, C, D)> {
    return lift4(toResult: { ($0, $1, $2, $3) })(a, b, c, d)
}

public func zip<A, B, C, D, E>(_ a: Result<A>, _ b: Result<B>, _ c: Result<C>, _ d: Result<D>, _ e: Result<E>) -> Result<(A, B, C, D, E)> {
    return lift5(toResult: { ($0, $1, $2, $3, $4) })(a, b, c, d, e)
}

import Foundation

public func lift2<A, B, C>(toFuture f: @escaping ((A, B) -> C)) -> ((Future<A>, Future<B>) -> Future<C>) {
    return { curry(f) <^> $0 <*> $1 }
}

public func lift3<A, B, C, D>(toFuture f: @escaping ((A, B, C) -> D)) -> ((Future<A>, Future<B>, Future<C>) -> Future<D>) {
    return { curry(f) <^> $0 <*> $1 <*> $2 }
}

public func lift4<A, B, C, D, E>(toFuture f: @escaping ((A, B, C, D) -> E)) -> ((Future<A>, Future<B>, Future<C>, Future<D>) -> Future<E>) {
    return { curry(f) <^> $0 <*> $1 <*> $2 <*> $3 }
}

public func lift5<A, B, C, D, E, F>(toFuture f: @escaping ((A, B, C, D, E) -> F)) -> ((Future<A>, Future<B>, Future<C>, Future<D>, Future<E>) -> Future<F>) {
    return { curry(f) <^> $0 <*> $1 <*> $2 <*> $3 <*> $4 }
}

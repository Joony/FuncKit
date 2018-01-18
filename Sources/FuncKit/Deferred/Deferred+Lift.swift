import Foundation

public func lift2<A, B, C>(toDeferred f: @escaping ((A, B) -> C)) -> ((Deferred<A>, Deferred<B>) -> Deferred<C>) {
    return { curry(f) <^> $0 <*> $1 }
}

public func lift3<A, B, C, D>(toDeferred f: @escaping ((A, B, C) -> D)) -> ((Deferred<A>, Deferred<B>, Deferred<C>) -> Deferred<D>) {
    return { curry(f) <^> $0 <*> $1 <*> $2 }
}

public func lift4<A, B, C, D, E>(toDeferred f: @escaping ((A, B, C, D) -> E)) -> ((Deferred<A>, Deferred<B>, Deferred<C>, Deferred<D>) -> Deferred<E>) {
    return { curry(f) <^> $0 <*> $1 <*> $2 <*> $3 }
}

public func lift5<A, B, C, D, E, F>(toDeferred f: @escaping ((A, B, C, D, E) -> F)) -> ((Deferred<A>, Deferred<B>, Deferred<C>, Deferred<D>, Deferred<E>) -> Deferred<F>) {
    return { curry(f) <^> $0 <*> $1 <*> $2 <*> $3 <*> $4 }
}

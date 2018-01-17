import Foundation

public func lift2<A, B, C>(toResult f: @escaping ((A, B) -> C)) -> ((Result<A>, Result<B>) -> Result<C>) {
    return { curry(f) <^> $0 <*> $1 }
}

public func lift3<A, B, C, D>(toResult f: @escaping ((A, B, C) -> D)) -> ((Result<A>, Result<B>, Result<C>) -> Result<D>) {
    return { curry(f) <^> $0 <*> $1 <*> $2 }
}

public func lift4<A, B, C, D, E>(toResult f: @escaping ((A, B, C, D) -> E)) -> ((Result<A>, Result<B>, Result<C>, Result<D>) -> Result<E>) {
    return { curry(f) <^> $0 <*> $1 <*> $2 <*> $3 }
}

public func lift5<A, B, C, D, E, F>(toResult f: @escaping ((A, B, C, D, E) -> F)) -> ((Result<A>, Result<B>, Result<C>, Result<D>, Result<E>) -> Result<F>) {
    return { curry(f) <^> $0 <*> $1 <*> $2 <*> $3 <*> $4 }
}

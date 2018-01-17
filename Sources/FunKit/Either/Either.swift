import Foundation

public enum Either<L, R> {
    case left(L)
    case right(R)
}

/// Bifunctor
extension Either {
    public func bimap<B, D>(_ f: ((L) -> B), _ g: ((R) -> D)) -> Either<B, D> {
        switch self {
        case let .left(value):
            return .left(f(value))
        case let .right(value):
            return .right(g(value))
        }
    }
    
    public func first<B>(_ f: @escaping (L) -> B) -> Either<B, R> {
        return self.bimap(f, identity)
    }
    
    public func second<D>(_ g: @escaping (R) -> D) -> Either<L, D> {
        return self.bimap(identity, g)
    }
}

extension Either {
    public func either<C>(onLeft: (L) -> C, onRight: (R) -> C) -> C {
        switch self {
        case let .left(value):
            return onLeft(value)
        case let .right(value):
            return onRight(value)
        }
    }
}

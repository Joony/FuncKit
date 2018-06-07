import Foundation

prefix operator ^
prefix func ^ <A, B>(f: @escaping (A) -> B) -> (A) -> Result<B> {
    return { .success(f($0)) }
}

enum OptionalFailureError<A, B>: Error, CustomStringConvertible {
    case optionalFailure(f: (A) -> B?)
    
    var description: String {
        switch self {
        case let .optionalFailure(f):
            return "OptionalFailureError.optionalFailure(\(type(of: f)))"
        }
    }
}

prefix func ^ <A, B>(f: @escaping (A) -> B?) -> (A) -> Result<B> {
    return {
        guard let b = f($0) else {
            return .failure(OptionalFailureError.optionalFailure(f: f))
        }
        return .success(b)
    }
}
prefix func ^ <A, B>(f: @escaping (A) -> Result<B>) -> (A) -> Future<B> {
    return { Future(f($0)) }
}

prefix operator ^^
prefix func ^^ <A, B>(f: @escaping (A) -> B) -> (A) -> Future<B> {
    return { Future(.success(f($0))) }
}

prefix func ^^ <A, B>(f: @escaping (A) -> B?) -> (A) -> Future<B> {
    return {
        guard let b = f($0) else {
            return Future(.failure(OptionalFailureError.optionalFailure(f: f)))
        }
        return Future(.success(b))
    }
}

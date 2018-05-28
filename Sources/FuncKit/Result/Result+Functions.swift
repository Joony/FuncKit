import Foundation

// Lift throwable to Result
public func lift<T, U>(toResult f: @escaping (T) throws -> U) -> ((T) -> Result<U>) {
    return { t1 in
        let result: Result<U>
        do {
            result = try .success(f(t1))
        } catch let error {
            return .failure(error)
        }
        return result
    }
}

// Optional lifting
enum ResultError: Error {
    case foundNil
}

public func lift<T, U>(optionalToResult f: @escaping (T) -> U?) -> ((T) -> Result<U>) {
    return { t in
        guard let u = f(t) else {
            return .failure(ResultError.foundNil)
        }
        return .success(u)
    }
}

// Passthrough
public func passthrough<T>(_ f: @escaping ((T) -> Void)) -> ((T) -> Result<T>) {
    return {
        f($0)
        return .success($0)
    }
}

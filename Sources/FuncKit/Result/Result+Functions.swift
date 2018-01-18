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

// Passthrough
public func passthrough<T>(_ f: @escaping ((T) -> Void)) -> ((T) -> Result<T>) {
    return {
        f($0)
        return .success($0)
    }
}

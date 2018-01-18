import Foundation

// Lift throwable to Future
public func lift<T, U>(toFuture f: @escaping (T) throws -> U) -> ((T) -> Future<U>) {
    return { t1 in
        let promise = Promise<U>()
        do {
            try promise.resolve(value: f(t1))
        } catch let error {
            promise.reject(error: error)
        }
        return promise
    }
}

// Lift Result to Future
public func lift<T, U>(resultToFuture f: @escaping (T) -> Result<U>) -> ((T) -> Future<U>) {
    return { t in
        let promise = Promise<U>()
        switch f(t) {
        case let .success(value):
            promise.resolve(value: value)
        case let .failure(error):
            promise.reject(error: error)
        }
        return promise
    }
}

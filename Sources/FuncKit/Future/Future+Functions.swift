import Foundation

public func lift<T, U>(toFuture f: @escaping (T) throws -> U, performOn: DispatchQueue = .global(qos: .background)) -> ((T) -> Future<U>) {
    return { t1 in
        return Promise<U>(queue: performOn) { promise in
            do {
                try promise.resolve(value: f(t1))
            } catch let error {
                promise.reject(error: error)
            }
        }
    }
}

public func lift<T, U>(resultToFuture f: @escaping (T) -> Result<U>, performOn: DispatchQueue = .global(qos: .background)) -> ((T) -> Future<U>) {
    return { t in
        return Promise<U>(queue: performOn) { promise in
            switch f(t) {
            case let .success(value):
                promise.resolve(value: value)
            case let .failure(error):
                promise.reject(error: error)
            }
        }
    }
}

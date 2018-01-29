import Foundation

public class Future<Wrapped> {
    public typealias ResultType = Result<Wrapped>
    public typealias Completion = (ResultType) -> ()
    
    fileprivate init() {}
    
    fileprivate var result: ResultType?
    private lazy var completions = [Completion]()
    
    fileprivate func add(completion: @escaping Completion) {
        self.completions.append(completion)
        self.result.map(completion)
    }
    
    fileprivate func complete(_ result: ResultType) {
        assert(self.result == nil, "Cannot set result (\(result)). Already completed with previous value (\(self.result!))")
        self.result = result
        self.completions.forEach { $0(result) }
        self.completions.removeAll()
    }
    
    public func finally(_ f: @escaping Completion) {
        self.add(completion: f)
    }
}

/// Functor
extension Future {
    @discardableResult public func map<U>(_ f: @escaping (Wrapped) -> U) -> Future<U> {
        let future = Future<U>()
        self.add(completion: { future.complete($0.map(f)) })
        return future
    }
}

/// Monad
extension Future {
    public convenience init(_ value: Wrapped) {
        self.init()
        self.complete(.success(value))
    }
    
    @discardableResult public func flatMap<U>(_ f: @escaping (Wrapped) -> Future<U>) -> Future<U> {
        return self.map(f).join()
    }
    
    public func join<U>() -> Future<U> where Wrapped == Future<U> {
        let future = Future<U>()
        self.add(completion: { result in
            switch result {
            case let .success(innerFuture):
                innerFuture.add(completion: future.complete)
            case let .failure(error):
                future.complete(.failure(error))
            }
        })
        return future
//        return self.flatMap(identity)
    }
}

/// Applicative
extension Future {
    public func apply<U>(_ f: Future<((Wrapped) -> U)>) -> Future<U> {
        return f.flatMap(self.map)
    }
}

/// Await
public func await<Wrapped>(_ future: Future<Wrapped>) -> Result<Wrapped> {
    assert(!Thread.isMainThread, "DO NOT BLOCK THE MAIN THREAD! Dispatch awaits on a background queue.")
    if let result = future.result {
        return result
    }
    let group = DispatchGroup()
    group.enter()
    future.finally { _ in
        group.leave()
    }
    group.wait()
    return future.result!
}

/// Promise
public class Promise<Wrapped>: Future<Wrapped> {
    public override init() { super.init() }
    
    public func resolve(value: Wrapped) {
        self.complete(.success(value))
    }
    
    public func reject(error: Error) {
        self.complete(.failure(error))
    }
}

extension Promise {
    public convenience init(queue: DispatchQueue = .global(qos: .background), operation: @escaping (Promise<Wrapped>) -> Void) {
        self.init()
        queue.async { operation(self) }
    }
    
    public func resolve(value: Wrapped, on queue: DispatchQueue) {
        queue.sync { self.complete(.success(value)) }
    }
    
    public func reject(error: Error, on queue: DispatchQueue) {
        queue.sync {
            self.complete(.failure(error))
        }
    }
}

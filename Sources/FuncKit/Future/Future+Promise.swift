import Foundation

var _counter: Int = 0
var counter: Int {
    _counter += 1
    return _counter
}

public class Future<Wrapped> {
    public typealias ResultType = Result<Wrapped>
    public typealias Completion = (ResultType) -> ()
    
    private let id: Int
    
    fileprivate init() {
        self.id = counter
    }
    
    fileprivate var result: ResultType?
    private lazy var completions = [Completion]()
    
    fileprivate func add(completion: @escaping Completion) {
        if self.result == nil {
            self.completions.append(completion)
        }
        self.result.map(completion)
    }
    
    var stack: String?
    var thead: Thread?
    fileprivate func complete(_ result: ResultType) {
        if self.result != nil {
//            print(self, self.id, self.result!, result, Thread.current, self.stack!)
            return
        }
        
        self.stack = Thread.callStackSymbols.joined(separator: "\n")
        self.thead = Thread.current

//        assert(self.result == nil, "Cannot set result (\(result)). Already completed with previous value (\(self.result!))")
        self.result = result
        self.completions.forEach { $0(result) }
        self.completions.removeAll()
    }
    
    public func finally(_ f: @escaping Completion) {
        self.add(completion: f)
    }
    
    public func onError(_ f: @escaping (Error) -> Void) {
        self.add { if case let .failure(error) = $0 { f(error) } }
    }
}

/// Functor
extension Future {
    @discardableResult public func map<U>(_ f: @escaping (Wrapped) -> U) -> Future<U> {
        let future = Future<U>()
        self.add { future.complete($0.map(f)) }
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
                innerFuture.add { innerResult in
                    if future.result != nil {
                        print("WTF?", self)
                    }
                    future.complete(innerResult)
                }
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
        if self.result != nil {
            print("WTF?")
        }
        self.complete(.success(value))
    }
    
    public func reject(error: Error) {
        if self.result != nil {
            print("WTF?")
        }
        self.complete(.failure(error))
    }
}

extension Promise {
    public func resolve(value: Wrapped, on queue: DispatchQueue) {
        queue.sync {
            if self.result != nil {
                print("WTF?")
            }
            self.complete(.success(value))
            
        }
    }
    
    public func reject(error: Error, on queue: DispatchQueue) {
        queue.sync {
            if self.result != nil {
                print("WTF?")
            }
            self.complete(.failure(error))
        }
    }
}

extension Future {
    public static func async(queue: DispatchQueue = .global(qos: .background), operation: @escaping (Promise<Wrapped>) -> Void) -> Future<Wrapped> {
        let promise = Promise<Wrapped>()
        queue.async { operation(promise) }
        return promise
    }
}

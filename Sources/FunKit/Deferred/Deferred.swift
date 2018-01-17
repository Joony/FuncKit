import Foundation

public class Deferred<Wrapped> {
    fileprivate var value: Wrapped?
    public typealias Completion = (Wrapped) -> ()
    private lazy var completions = [Completion]()

    public init() {}
    
    fileprivate func add(completion: @escaping Completion) {
        self.completions.append(completion)
        self.value.map(completion)
    }
    
    public func complete(_ value: Wrapped) {
        assert(self.value == nil, "Cannot set value (\(value)). Already completed with previous value (\(self.value!))")
        self.value = value
        self.completions.forEach { $0(value) }
        self.completions.removeAll()
    }
}

/// Functor
extension Deferred {
    public convenience init(_ value: Wrapped) {
        self.init()
        self.value = value
    }
    
    @discardableResult public func map<U>(_ f: @escaping (Wrapped) -> U) -> Deferred<U> {
        let deferred = Deferred<U>()
        self.add(completion: { deferred.complete(f($0)) })
        return deferred
    }
}

/// Monad
extension Deferred {
    @discardableResult public func flatMap<U>(_ f: @escaping (Wrapped) -> Deferred<U>) -> Deferred<U> {
        return self.map(f).join()
    }
    
    public func join<U>() -> Deferred<U> where Wrapped == Deferred<U> {
        let deferred = Deferred<U>()
        self.add(completion: { $0.add(completion: deferred.complete) })
        return deferred
    }
}

/// Applicative
extension Deferred {
    public func apply<U>(_ f: Deferred<((Wrapped) -> U)>) -> Deferred<U> {
        return f.flatMap(self.map)
    }
}

/// Await
public func await<Wrapped>(_ deferred: Deferred<Wrapped>) -> Wrapped {
    if let value = deferred.value {
        return value
    }
    let group = DispatchGroup()
    group.enter()
    deferred.map { _ in
        group.leave()
    }
    group.wait()
    return deferred.value!
}

import Foundation

struct Queue {
    static func main<A, B>(_ f: @escaping (A) -> B) -> (A) -> Future<B> {
        return { a in
            return .async(queue: .main) { promise in
                promise.resolve(value: f(a), on: .main)
            }
        }
    }
    
    static func wait<A>(seconds: Int) -> (A) -> Future<A> {
        return { a in
            return .async { promise in
                DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(seconds)) {
                    promise.resolve(value: a)
                }
            }
        }
    }
}

import Foundation

public func flatten<A, B, C>(a: (A, (B, C))) -> (A, B, C) {
    return (a.0, a.1.0, a.1.1)
}

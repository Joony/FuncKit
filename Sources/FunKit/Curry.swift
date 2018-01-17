import Foundation

public func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) }}
}

public func curry<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in { b in { c in f(a, b, c) }}}
}

public func curry<A, B, C, D, E>(_ f: @escaping (A, B, C, D) -> E) -> (A) -> (B) -> (C) -> (D) -> E {
    return { a in { b in { c in { d in f(a, b, c, d) }}}}
}

public func curry<A, B, C, D, E, F>(_ f: @escaping (A, B, C, D, E) -> F) -> (A) -> (B) -> (C) -> (D) -> (E) -> F {
    return { a in { b in { c in { d in { e in f(a, b, c, d, e) }}}}}
}

public func curryr<A, B, C>(_ f: @escaping (A, B) -> C) -> (B) -> (A) -> C {
    return { b in { a in f(a, b) }}
}

public func curryr<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (C) -> (B) -> (A) -> D {
    return { c in { b in { a in f(a, b, c) }}}
}

public func curryr<A, B, C, D, E>(_ f: @escaping (A, B, C, D) -> E) -> (D) -> (C) -> (B) -> (A) -> E {
    return { d in { c in { b in { a in f(a, b, c, d) }}}}
}

public func curryr<A, B, C, D, E, F>(_ f: @escaping (A, B, C, D, E) -> F) -> (E) -> (D) -> (C) -> (B) -> (A) -> F {
    return { e in { d in { c in { b in { a in f(a, b, c, d, e) }}}}}
}

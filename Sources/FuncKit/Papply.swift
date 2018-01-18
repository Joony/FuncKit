import Foundation

/// Partial Application

// Take a function, apply some of the arguments, and return a function that takes the remainder.

func papply<A, B>(_ a: A, f: @escaping (A) -> B) -> () -> B  {
    return { f(a) }
}

func papply<A, B>(_ a: A, f: @escaping (A) -> B) -> () -> B where A: AnyObject {
    return { [unowned a] in f(a) }
}

func papply<A, B, C>(_ a: A, f: @escaping (A, B) -> C) -> (B) -> C  {
    return { f(a, $0) }
}

func papply<A, B, C>(_ a: A, f: @escaping (A, B) -> C) -> (B) -> C where A: AnyObject {
    return { [unowned a] in f(a, $0) }
}

func papply<A, B, C>(_ a: A, _ b: B, f: @escaping (A, B) -> C) -> () -> C  {
    return { f(a, b) }
}

func papply<A, B, C>(_ a: A, _ b: B, f: @escaping (A, B) -> C) -> () -> C where A: AnyObject {
    return { [unowned a] in f(a, b) }
}

func papply<A, B, C>(_ a: A, _ b: B, f: @escaping (A, B) -> C) -> () -> C where B: AnyObject {
    return { [unowned b] in f(a, b) }
}

func papply<A, B, C>(_ a: A, _ b: B, f: @escaping (A, B) -> C) -> () -> C where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b) }
}

func papply<A, B, C, D>(_ a: A, f: @escaping (A, B, C) -> D) -> (B, C) -> D  {
    return { f(a, $0, $1) }
}

func papply<A, B, C, D>(_ a: A, f: @escaping (A, B, C) -> D) -> (B, C) -> D where A: AnyObject {
    return { [unowned a] in f(a, $0, $1) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, f: @escaping (A, B, C) -> D) -> (C) -> D  {
    return { f(a, b, $0) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, f: @escaping (A, B, C) -> D) -> (C) -> D where A: AnyObject {
    return { [unowned a] in f(a, b, $0) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, f: @escaping (A, B, C) -> D) -> (C) -> D where B: AnyObject {
    return { [unowned b] in f(a, b, $0) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, f: @escaping (A, B, C) -> D) -> (C) -> D where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, $0) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D  {
    return { f(a, b, c) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where A: AnyObject {
    return { [unowned a] in f(a, b, c) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where B: AnyObject {
    return { [unowned b] in f(a, b, c) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where C: AnyObject {
    return { [unowned c] in f(a, b, c) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, c) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where A: AnyObject, C: AnyObject {
    return { [unowned a, unowned c] in f(a, b, c) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f(a, b, c) }
}

func papply<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where A: AnyObject, B: AnyObject, C: AnyObject {
    return { [unowned a, unowned b, unowned c] in f(a, b, c) }
}

func papply<A, B, C, D, E>(_ a: A, f: @escaping (A, B, C, D) -> E) -> (B, C, D) -> E  {
    return { f(a, $0, $1, $2) }
}

func papply<A, B, C, D, E>(_ a: A, f: @escaping (A, B, C, D) -> E) -> (B, C, D) -> E where A: AnyObject {
    return { [unowned a] in f(a, $0, $1, $2) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, f: @escaping (A, B, C, D) -> E) -> (C, D) -> E  {
    return { f(a, b, $0, $1) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, f: @escaping (A, B, C, D) -> E) -> (C, D) -> E where A: AnyObject {
    return { [unowned a] in f(a, b, $0, $1) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, f: @escaping (A, B, C, D) -> E) -> (C, D) -> E where B: AnyObject {
    return { [unowned b] in f(a, b, $0, $1) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, f: @escaping (A, B, C, D) -> E) -> (C, D) -> E where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, $0, $1) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D) -> E) -> (D) -> E  {
    return { f(a, b, c, $0) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D) -> E) -> (D) -> E where A: AnyObject {
    return { [unowned a] in f(a, b, c, $0) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D) -> E) -> (D) -> E where B: AnyObject {
    return { [unowned b] in f(a, b, c, $0) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D) -> E) -> (D) -> E where C: AnyObject {
    return { [unowned c] in f(a, b, c, $0) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D) -> E) -> (D) -> E where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, c, $0) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D) -> E) -> (D) -> E where A: AnyObject, C: AnyObject {
    return { [unowned a, unowned c] in f(a, b, c, $0) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D) -> E) -> (D) -> E where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f(a, b, c, $0) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D) -> E) -> (D) -> E where A: AnyObject, B: AnyObject, C: AnyObject {
    return { [unowned a, unowned b, unowned c] in f(a, b, c, $0) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E  {
    return { f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject {
    return { [unowned a] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where B: AnyObject {
    return { [unowned b] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where C: AnyObject {
    return { [unowned c] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where D: AnyObject {
    return { [unowned d] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, C: AnyObject {
    return { [unowned a, unowned c] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, D: AnyObject {
    return { [unowned a, unowned d] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where B: AnyObject, D: AnyObject {
    return { [unowned b, unowned d] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where C: AnyObject, D: AnyObject {
    return { [unowned c, unowned d] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, B: AnyObject, C: AnyObject {
    return { [unowned a, unowned b, unowned c] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, B: AnyObject, D: AnyObject {
    return { [unowned a, unowned b, unowned d] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned a, unowned c, unowned d] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned b, unowned c, unowned d] in f(a, b, c, d) }
}

func papply<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned a, unowned b, unowned c, unowned d] in f(a, b, c, d) }
}

func papply<A, B, C, D, E, F>(_ a: A, f: @escaping (A, B, C, D, E) -> F) -> (B, C, D, E) -> F  {
    return { f(a, $0, $1, $2, $3) }
}

func papply<A, B, C, D, E, F>(_ a: A, f: @escaping (A, B, C, D, E) -> F) -> (B, C, D, E) -> F where A: AnyObject {
    return { [unowned a] in f(a, $0, $1, $2, $3) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, f: @escaping (A, B, C, D, E) -> F) -> (C, D, E) -> F  {
    return { f(a, b, $0, $1, $2) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, f: @escaping (A, B, C, D, E) -> F) -> (C, D, E) -> F where A: AnyObject {
    return { [unowned a] in f(a, b, $0, $1, $2) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, f: @escaping (A, B, C, D, E) -> F) -> (C, D, E) -> F where B: AnyObject {
    return { [unowned b] in f(a, b, $0, $1, $2) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, f: @escaping (A, B, C, D, E) -> F) -> (C, D, E) -> F where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, $0, $1, $2) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D, E) -> F) -> (D, E) -> F  {
    return { f(a, b, c, $0, $1) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D, E) -> F) -> (D, E) -> F where A: AnyObject {
    return { [unowned a] in f(a, b, c, $0, $1) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D, E) -> F) -> (D, E) -> F where B: AnyObject {
    return { [unowned b] in f(a, b, c, $0, $1) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D, E) -> F) -> (D, E) -> F where C: AnyObject {
    return { [unowned c] in f(a, b, c, $0, $1) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D, E) -> F) -> (D, E) -> F where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, c, $0, $1) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D, E) -> F) -> (D, E) -> F where A: AnyObject, C: AnyObject {
    return { [unowned a, unowned c] in f(a, b, c, $0, $1) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D, E) -> F) -> (D, E) -> F where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f(a, b, c, $0, $1) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C, D, E) -> F) -> (D, E) -> F where A: AnyObject, B: AnyObject, C: AnyObject {
    return { [unowned a, unowned b, unowned c] in f(a, b, c, $0, $1) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F  {
    return { f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where A: AnyObject {
    return { [unowned a] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where B: AnyObject {
    return { [unowned b] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where C: AnyObject {
    return { [unowned c] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where D: AnyObject {
    return { [unowned d] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where A: AnyObject, C: AnyObject {
    return { [unowned a, unowned c] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where A: AnyObject, D: AnyObject {
    return { [unowned a, unowned d] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where B: AnyObject, D: AnyObject {
    return { [unowned b, unowned d] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where C: AnyObject, D: AnyObject {
    return { [unowned c, unowned d] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where A: AnyObject, B: AnyObject, C: AnyObject {
    return { [unowned a, unowned b, unowned c] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where A: AnyObject, B: AnyObject, D: AnyObject {
    return { [unowned a, unowned b, unowned d] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where A: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned a, unowned c, unowned d] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned b, unowned c, unowned d] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D, E) -> F) -> (E) -> F where A: AnyObject, B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned a, unowned b, unowned c, unowned d] in f(a, b, c, d, $0) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F  {
    return { f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject {
    return { [unowned a] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject {
    return { [unowned b] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where C: AnyObject {
    return { [unowned c] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where D: AnyObject {
    return { [unowned d] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where E: AnyObject {
    return { [unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, C: AnyObject {
    return { [unowned a, unowned c] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, D: AnyObject {
    return { [unowned a, unowned d] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, E: AnyObject {
    return { [unowned a, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, D: AnyObject {
    return { [unowned b, unowned d] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, E: AnyObject {
    return { [unowned b, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where C: AnyObject, D: AnyObject {
    return { [unowned c, unowned d] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where C: AnyObject, E: AnyObject {
    return { [unowned c, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where D: AnyObject, E: AnyObject {
    return { [unowned d, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, C: AnyObject {
    return { [unowned a, unowned b, unowned c] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, D: AnyObject {
    return { [unowned a, unowned b, unowned d] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, E: AnyObject {
    return { [unowned a, unowned b, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned a, unowned c, unowned d] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, C: AnyObject, E: AnyObject {
    return { [unowned a, unowned c, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned a, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned b, unowned c, unowned d] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, C: AnyObject, E: AnyObject {
    return { [unowned b, unowned c, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned b, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned c, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned a, unowned b, unowned c, unowned d] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, C: AnyObject, E: AnyObject {
    return { [unowned a, unowned b, unowned c, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned a, unowned b, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned a, unowned c, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned b, unowned c, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papply<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned a, unowned b, unowned c, unowned d, unowned e] in f(a, b, c, d, e) }
}


// Partial application from the right

func papplyr<A, B>(_ a: A, f: @escaping (A) -> B) -> () -> B  {
    return { f(a) }
}

func papplyr<A, B>(_ a: A, f: @escaping (A) -> B) -> () -> B where A: AnyObject {
    return { [unowned a] in f(a) }
}

func papplyr<A, B, C>(_ b: B, f: @escaping (A, B) -> C) -> (A) -> C  {
    return { f($0, b) }
}

func papplyr<A, B, C>(_ b: B, f: @escaping (A, B) -> C) -> (A) -> C where B: AnyObject {
    return { [unowned b] in f($0, b) }
}

func papplyr<A, B, C>(_ a: A, _ b: B, f: @escaping (A, B) -> C) -> () -> C  {
    return { f(a, b) }
}

func papplyr<A, B, C>(_ a: A, _ b: B, f: @escaping (A, B) -> C) -> () -> C where A: AnyObject {
    return { [unowned a] in f(a, b) }
}

func papplyr<A, B, C>(_ a: A, _ b: B, f: @escaping (A, B) -> C) -> () -> C where B: AnyObject {
    return { [unowned b] in f(a, b) }
}

func papplyr<A, B, C>(_ a: A, _ b: B, f: @escaping (A, B) -> C) -> () -> C where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b) }
}

func papplyr<A, B, C, D>(_ c: C, f: @escaping (A, B, C) -> D) -> (A, B) -> D  {
    return { f($0, $1, c) }
}

func papplyr<A, B, C, D>(_ c: C, f: @escaping (A, B, C) -> D) -> (A, B) -> D where C: AnyObject {
    return { [unowned c] in f($0, $1, c) }
}

func papplyr<A, B, C, D>(_ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> (A) -> D  {
    return { f($0, b, c) }
}

func papplyr<A, B, C, D>(_ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> (A) -> D where B: AnyObject {
    return { [unowned b] in f($0, b, c) }
}

func papplyr<A, B, C, D>(_ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> (A) -> D where C: AnyObject {
    return { [unowned c] in f($0, b, c) }
}

func papplyr<A, B, C, D>(_ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> (A) -> D where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f($0, b, c) }
}

func papplyr<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D  {
    return { f(a, b, c) }
}

func papplyr<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where A: AnyObject {
    return { [unowned a] in f(a, b, c) }
}

func papplyr<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where B: AnyObject {
    return { [unowned b] in f(a, b, c) }
}

func papplyr<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where C: AnyObject {
    return { [unowned c] in f(a, b, c) }
}

func papplyr<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, c) }
}

func papplyr<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where A: AnyObject, C: AnyObject {
    return { [unowned a, unowned c] in f(a, b, c) }
}

func papplyr<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f(a, b, c) }
}

func papplyr<A, B, C, D>(_ a: A, _ b: B, _ c: C, f: @escaping (A, B, C) -> D) -> () -> D where A: AnyObject, B: AnyObject, C: AnyObject {
    return { [unowned a, unowned b, unowned c] in f(a, b, c) }
}

func papplyr<A, B, C, D, E>(_ d: D, f: @escaping (A, B, C, D) -> E) -> (A, B, C) -> E  {
    return { f($0, $1, $2, d) }
}

func papplyr<A, B, C, D, E>(_ d: D, f: @escaping (A, B, C, D) -> E) -> (A, B, C) -> E where D: AnyObject {
    return { [unowned d] in f($0, $1, $2, d) }
}

func papplyr<A, B, C, D, E>(_ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A, B) -> E  {
    return { f($0, $1, c, d) }
}

func papplyr<A, B, C, D, E>(_ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A, B) -> E where C: AnyObject {
    return { [unowned c] in f($0, $1, c, d) }
}

func papplyr<A, B, C, D, E>(_ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A, B) -> E where D: AnyObject {
    return { [unowned d] in f($0, $1, c, d) }
}

func papplyr<A, B, C, D, E>(_ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A, B) -> E where C: AnyObject, D: AnyObject {
    return { [unowned c, unowned d] in f($0, $1, c, d) }
}

func papplyr<A, B, C, D, E>(_ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A) -> E  {
    return { f($0, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A) -> E where B: AnyObject {
    return { [unowned b] in f($0, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A) -> E where C: AnyObject {
    return { [unowned c] in f($0, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A) -> E where D: AnyObject {
    return { [unowned d] in f($0, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A) -> E where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f($0, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A) -> E where B: AnyObject, D: AnyObject {
    return { [unowned b, unowned d] in f($0, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A) -> E where C: AnyObject, D: AnyObject {
    return { [unowned c, unowned d] in f($0, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> (A) -> E where B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned b, unowned c, unowned d] in f($0, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E  {
    return { f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject {
    return { [unowned a] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where B: AnyObject {
    return { [unowned b] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where C: AnyObject {
    return { [unowned c] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where D: AnyObject {
    return { [unowned d] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, C: AnyObject {
    return { [unowned a, unowned c] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, D: AnyObject {
    return { [unowned a, unowned d] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where B: AnyObject, D: AnyObject {
    return { [unowned b, unowned d] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where C: AnyObject, D: AnyObject {
    return { [unowned c, unowned d] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, B: AnyObject, C: AnyObject {
    return { [unowned a, unowned b, unowned c] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, B: AnyObject, D: AnyObject {
    return { [unowned a, unowned b, unowned d] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned a, unowned c, unowned d] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned b, unowned c, unowned d] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E>(_ a: A, _ b: B, _ c: C, _ d: D, f: @escaping (A, B, C, D) -> E) -> () -> E where A: AnyObject, B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned a, unowned b, unowned c, unowned d] in f(a, b, c, d) }
}

func papplyr<A, B, C, D, E, F>(_ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B, C, D) -> F  {
    return { f($0, $1, $2, $3, e) }
}

func papplyr<A, B, C, D, E, F>(_ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B, C, D) -> F where E: AnyObject {
    return { [unowned e] in f($0, $1, $2, $3, e) }
}

func papplyr<A, B, C, D, E, F>(_ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B, C) -> F  {
    return { f($0, $1, $2, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B, C) -> F where D: AnyObject {
    return { [unowned d] in f($0, $1, $2, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B, C) -> F where E: AnyObject {
    return { [unowned e] in f($0, $1, $2, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B, C) -> F where D: AnyObject, E: AnyObject {
    return { [unowned d, unowned e] in f($0, $1, $2, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B) -> F  {
    return { f($0, $1, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B) -> F where C: AnyObject {
    return { [unowned c] in f($0, $1, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B) -> F where D: AnyObject {
    return { [unowned d] in f($0, $1, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B) -> F where E: AnyObject {
    return { [unowned e] in f($0, $1, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B) -> F where C: AnyObject, D: AnyObject {
    return { [unowned c, unowned d] in f($0, $1, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B) -> F where C: AnyObject, E: AnyObject {
    return { [unowned c, unowned e] in f($0, $1, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B) -> F where D: AnyObject, E: AnyObject {
    return { [unowned d, unowned e] in f($0, $1, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A, B) -> F where C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned c, unowned d, unowned e] in f($0, $1, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F  {
    return { f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where B: AnyObject {
    return { [unowned b] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where C: AnyObject {
    return { [unowned c] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where D: AnyObject {
    return { [unowned d] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where E: AnyObject {
    return { [unowned e] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where B: AnyObject, D: AnyObject {
    return { [unowned b, unowned d] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where B: AnyObject, E: AnyObject {
    return { [unowned b, unowned e] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where C: AnyObject, D: AnyObject {
    return { [unowned c, unowned d] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where C: AnyObject, E: AnyObject {
    return { [unowned c, unowned e] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where D: AnyObject, E: AnyObject {
    return { [unowned d, unowned e] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned b, unowned c, unowned d] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where B: AnyObject, C: AnyObject, E: AnyObject {
    return { [unowned b, unowned c, unowned e] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where B: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned b, unowned d, unowned e] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned c, unowned d, unowned e] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> (A) -> F where B: AnyObject, C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned b, unowned c, unowned d, unowned e] in f($0, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F  {
    return { f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject {
    return { [unowned a] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject {
    return { [unowned b] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where C: AnyObject {
    return { [unowned c] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where D: AnyObject {
    return { [unowned d] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where E: AnyObject {
    return { [unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject {
    return { [unowned a, unowned b] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, C: AnyObject {
    return { [unowned a, unowned c] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, D: AnyObject {
    return { [unowned a, unowned d] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, E: AnyObject {
    return { [unowned a, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, C: AnyObject {
    return { [unowned b, unowned c] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, D: AnyObject {
    return { [unowned b, unowned d] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, E: AnyObject {
    return { [unowned b, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where C: AnyObject, D: AnyObject {
    return { [unowned c, unowned d] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where C: AnyObject, E: AnyObject {
    return { [unowned c, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where D: AnyObject, E: AnyObject {
    return { [unowned d, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, C: AnyObject {
    return { [unowned a, unowned b, unowned c] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, D: AnyObject {
    return { [unowned a, unowned b, unowned d] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, E: AnyObject {
    return { [unowned a, unowned b, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned a, unowned c, unowned d] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, C: AnyObject, E: AnyObject {
    return { [unowned a, unowned c, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned a, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned b, unowned c, unowned d] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, C: AnyObject, E: AnyObject {
    return { [unowned b, unowned c, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned b, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned c, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, C: AnyObject, D: AnyObject {
    return { [unowned a, unowned b, unowned c, unowned d] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, C: AnyObject, E: AnyObject {
    return { [unowned a, unowned b, unowned c, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned a, unowned b, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned a, unowned c, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where B: AnyObject, C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned b, unowned c, unowned d, unowned e] in f(a, b, c, d, e) }
}

func papplyr<A, B, C, D, E, F>(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E, f: @escaping (A, B, C, D, E) -> F) -> () -> F where A: AnyObject, B: AnyObject, C: AnyObject, D: AnyObject, E: AnyObject {
    return { [unowned a, unowned b, unowned c, unowned d, unowned e] in f(a, b, c, d, e) }
}




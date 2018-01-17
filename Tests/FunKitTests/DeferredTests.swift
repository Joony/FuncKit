//
//  DeferredTests.swift
//  FunKitTests
//
//  Created by Jonathan McAlister on 11/01/2018.
//  Copyright © 2018 FunKit. All rights reserved.
//

import XCTest
@testable import FunKit

class DeferredTests: XCTestCase {

    // MARK: - Functor Laws
    
    // Functors must preserve identity morphisms
    func testFunctorPreserveIdentity() {
        let a = Deferred(101)
        let b = identity <^> Deferred(101)
        XCTAssertEqual(⏱a, ⏱b)
    }
    
    /// Functors preserve composition of morphisms
    func testFunctorComposition() {
        let f = { (int: Int) in int + 10 }
        let g = { (int: Int) in int * 4 }
        let a = (f >>> g) <^> Deferred(101)
        let b = g <^> (f <^> Deferred(101))
        XCTAssertEqual(⏱a, ⏱b)
    }
    
    // MARK: - Monad Laws
    
    // Left identity
    // (return v) >>= f ≡ f v
    func testMonadLeftIdentity() {
        let f = { (int: Int) in Deferred(int + 10) }
        let a = Deferred(101) >>= f
        let b = f(101)
        XCTAssertEqual(⏱a, ⏱b)
    }
    
    // Right identity
    // m >>= return ≡ m
    func testMonadRightIdentity() {
        let a = Deferred(101) >>= Deferred.init
        let b = Deferred(101)
        XCTAssertEqual(⏱a, ⏱b)
    }
    
    // Associativity
    // (m >>= f) >>= g ≡ m >>= ( \x -> (f x >>= g) )
    func testMonadAssociativity() {
        let f = { (int: Int) in Deferred(int + 10) }
        let g = { (int: Int) in Deferred(int * 4) }
        let a = (Deferred(101) >>= f) >>= g
        let b = Deferred(101) >>= { f($0) >>= g }
        XCTAssertEqual(⏱a, ⏱b)
    }
    
    // MARK: - Applicative Laws
    
    // Identity
    // pure id <*> v = v
    func testApplicativeIdentity() {
        let a = Deferred(identity) <*> Deferred(101)
        let b = Deferred(101)
        XCTAssertEqual(⏱a, ⏱b)
    }
    
    // Homomorphism
    // pure f <*> pure x = pure (f x)
    func testApplicativeHomomorphism() {
        let f = { (int: Int) in int + 10 }
        let a = Deferred(f) <*> Deferred(101)
        let b = Deferred(f(101))
        XCTAssertEqual(⏱a, ⏱b)
    }
    
    // Interchange
    // u <*> pure y = pure ($ y) <*> u
    func testApplicativeInterchange() {
        func `$` <A, B>(a: A, f: (A) -> B) -> B { return f(a) }
        let f = { (int: Int) in int + 10 }
        let a = Deferred(f) <*> Deferred(101)
        let b = Deferred(curry(`$`)(101)) <*> Deferred(f)
        XCTAssertEqual(⏱a, ⏱b)
    }
    
    // Composition
    // pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
    func testApplicativeComposition() {
        let f = { (int: Int) in int + 10 }
        let g = { (int: Int) in int * 4 }
        let a = Deferred(curry(<<<)) <*> Deferred(f) <*> Deferred(g) <*> Deferred(101)
        let b = Deferred(f) <*> (Deferred(g) <*> Deferred(101))
        XCTAssertEqual(⏱a, ⏱b)
    }
    
    // MARK: - Test Deferred
    
    func testAsyncOperationMap() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let deferred = self.createDeferredInt(from: 101)
        deferred.map { int in
            XCTAssertEqual(int, 101)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testAsyncOperationFlatMap() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let deferred = self.createDeferredInt(from: 101) >>= self.createDeferredString(from:)
        deferred.map { string in
            XCTAssertEqual(string, "101")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAsyncOperationFlatMapAwait() {
        let deferred = self.createDeferredInt(from: 101) >>= self.createDeferredString(from:)
        let string = await(deferred)
        XCTAssertEqual(string, "101")
    }
    
    func testAsyncOperationFlatMapAwaitKleisliComposition() {
        let deferred = self.createDeferredInt(from:) >=> self.createDeferredString(from:)
        let string = await(deferred(101))
        XCTAssertEqual(string, "101")
    }
    
    // MARK: - Test Deferred Zip
    
    // ZIP is implemented in terms of Lift, and Lift is implemented in terms of Applicative, so if Zip works, it all works.
    // ZIP performs all operations asynchronously in parallel and only returns when all of the values have been resolved.
    
    func testAsyncOperationZip2() {
        let deferred = zip(self.createDeferredInt(from: 101),
                           self.createDeferredString(from: 102))
        let (int, string) = await(deferred)
        XCTAssertEqual(int, 101)
        XCTAssertEqual(string, "102")
    }
    
    func testAsyncOperationZip3() {
        let deferred = zip(self.createDeferredInt(from: 101),
                           self.createDeferredString(from: 102),
                           self.createDeferredBool(from: true))
        let (int, string, bool) = await(deferred)
        XCTAssertEqual(int, 101)
        XCTAssertEqual(string, "102")
        XCTAssertEqual(bool, false)
    }
    
    func testAsyncOperationZip4() {
        let deferred = zip(self.createDeferredInt(from: 101),
                           self.createDeferredString(from: 102),
                           self.createDeferredBool(from: true),
                           self.createDeferredInt(from: 121))
        let (int, string, bool, int2) = await(deferred)
        XCTAssertEqual(int, 101)
        XCTAssertEqual(string, "102")
        XCTAssertEqual(bool, false)
        XCTAssertEqual(int2, 121)
    }
    
    func testAsyncOperationZip5() {
        let deferred = zip(self.createDeferredInt(from: 101),
                           self.createDeferredString(from: 102),
                           self.createDeferredBool(from: true),
                           self.createDeferredInt(from: 121),
                           self.createDeferredString(from: 122))
        let (int, string, bool, int2, string2) = await(deferred)
        XCTAssertEqual(int, 101)
        XCTAssertEqual(string, "102")
        XCTAssertEqual(bool, false)
        XCTAssertEqual(int2, 121)
        XCTAssertEqual(string2, "122")
    }
    
    // MARK: - Create Deferred functions
    
    func createDeferredInt(from int: Int) -> Deferred<Int> {
        let deferred = Deferred<Int>()
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
            deferred.complete(int)
        }
        return deferred
    }
    
    func createDeferredString(from int: Int) -> Deferred<String> {
        let deferred = Deferred<String>()
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
            deferred.complete(String(int))
        }
        return deferred
    }
    
    func createDeferredBool(from bool: Bool) -> Deferred<Bool> {
        let deferred = Deferred<Bool>()
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
            deferred.complete(!bool)
        }
        return deferred
    }
    
}

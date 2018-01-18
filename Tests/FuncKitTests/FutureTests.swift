//
//  FutureTests.swift
//  FunKitTests
//
//  Created by Jonathan McAlister on 12/01/2018.
//  Copyright © 2018 FunKit. All rights reserved.
//

import XCTest
@testable import FuncKit

class FutureTests: XCTestCase {
    
    // MARK: - Functor Laws
    
    // Functors must preserve identity morphisms
    func testFunctorPreserveIdentity() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let a = Future(101)
        let b = identity <^> Future(101)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱a).successValue, (⏱b).successValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    /// Functors preserve composition of morphisms
    func testFunctorComposition() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let f = { (int: Int) in int + 10 }
        let g = { (int: Int) in int * 4 }
        let a = (f >>> g) <^> Future(101)
        let b = g <^> (f <^> Future(101))
        DispatchQueue.global().async {
            XCTAssertEqual((⏱a).successValue, (⏱b).successValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    // MARK: - Monad Laws
    
    // Left identity
    // (return v) >>= f ≡ f v
    func testMonadLeftIdentity() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let f = { (int: Int) in Future(int + 10) }
        let a = Future(101) >>= f
        let b = f(101)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱a).successValue, (⏱b).successValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    // Right identity
    // m >>= return ≡ m
    func testMonadRightIdentity() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let a = Future(101) >>= Future.init
        let b = Future(101)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱a).successValue, (⏱b).successValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    // Associativity
    // (m >>= f) >>= g ≡ m >>= ( \x -> (f x >>= g) )
    func testMonadAssociativity() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let f = { (int: Int) in Future(int + 10) }
        let g = { (int: Int) in Future(int * 4) }
        let a = (Future(101) >>= f) >>= g
        let b = Future(101) >>= { f($0) >>= g }
        DispatchQueue.global().async {
            XCTAssertEqual((⏱a).successValue, (⏱b).successValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    // MARK: - Applicative Laws
    
    // Identity
    // pure id <*> v = v
    func testApplicativeIdentity() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let a = Future(identity) <*> Future(101)
        let b = Future(101)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱a).successValue, (⏱b).successValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    // Homomorphism
    // pure f <*> pure x = pure (f x)
    func testApplicativeHomomorphism() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let f = { (int: Int) in int + 10 }
        let a = Future(f) <*> Future(101)
        let b = Future(f(101))
        DispatchQueue.global().async {
            XCTAssertEqual((⏱a).successValue, (⏱b).successValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    // Interchange
    // u <*> pure y = pure ($ y) <*> u
    func testApplicativeInterchange() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        func `$` <A, B>(a: A, f: (A) -> B) -> B { return f(a) }
        let f = { (int: Int) in int + 10 }
        let a = Future(f) <*> Future(101)
        let b = Future(curry(`$`)(101)) <*> Future(f)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱a).successValue, (⏱b).successValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    // Composition
    // pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
    func testApplicativeComposition() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let f = { (int: Int) in int + 10 }
        let g = { (int: Int) in int * 4 }
        let a = Future(curry(<<<)) <*> Future(f) <*> Future(g) <*> Future(101)
        let b = Future(f) <*> (Future(g) <*> Future(101))
        DispatchQueue.global().async {
            XCTAssertEqual((⏱a).successValue, (⏱b).successValue)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    // MARK: - Test Future Success
    
    func testAsyncOperationMap() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = self.createFutureInt(from: 101)
        future.map { int in
            XCTAssertEqual(int, 101)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testAsyncOperationFlatMap() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = self.createFutureInt(from: 101) >>= self.createFutureString(from:)
        future.map { string in
            XCTAssertEqual(string, "101")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAsyncOperationFlatMapAwait() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = self.createFutureInt(from: 101) >>= self.createFutureString(from:)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱future).successValue, "101")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAsyncOperationFlatMapAwaitKleisliComposition() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = self.createFutureInt(from:) >=> self.createFutureString(from:)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱future(101)).successValue, "101")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - Test Future Failure
    
    func testAsyncOperationFailure() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = self.createFutureIntFailure(from: 101)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱future).failureValue as? FutureError, FutureError.failedInt)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testAsyncOperationFlatMapFailure() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = self.createFutureIntFailure(from: 101) >>= self.createFutureString(from:)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱future).failureValue as? FutureError, FutureError.failedInt)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    // MARK: - Test Promise closures
    
    func testAsyncOperationClosure() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let promise = self.createFutureIntClosure(from: 101)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱promise).successValue, 101)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testAsyncOperationClosureFailure() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = self.createFutureIntClosureFailure(from: 101)
        DispatchQueue.global().async {
            XCTAssertEqual((⏱future).failureValue as? FutureError, FutureError.failedInt)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - Test Future Zip
    
    // ZIP is implemented in terms of Lift, and Lift is implemented in terms of Applicative, so if Zip works, it all works.
    // ZIP performs all operations asynchronously in parallel and only returns when all of the values have been resolved.
    
    func testAsyncOperationZip2() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = zip(self.createFutureInt(from: 101),
                         self.createFutureString(from: 102))
        DispatchQueue.global().async {
            let result = ⏱future
            XCTAssertEqual(result.successValue?.0, 101)
            XCTAssertEqual(result.successValue?.1, "102")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAsyncOperationZip3() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = zip(self.createFutureInt(from: 101),
                         self.createFutureString(from: 102),
                         self.createFutureBool(from: true))
        DispatchQueue.global().async {
            let result = ⏱future
            XCTAssertEqual(result.successValue?.0, 101)
            XCTAssertEqual(result.successValue?.1, "102")
            XCTAssertEqual(result.successValue?.2, false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAsyncOperationZip4() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = zip(self.createFutureInt(from: 101),
                         self.createFutureString(from: 102),
                         self.createFutureBool(from: true),
                         self.createFutureInt(from: 121))
        DispatchQueue.global().async {
            let result = ⏱future
            XCTAssertEqual(result.successValue?.0, 101)
            XCTAssertEqual(result.successValue?.1, "102")
            XCTAssertEqual(result.successValue?.2, false)
            XCTAssertEqual(result.successValue?.3, 121)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAsyncOperationZip5() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = zip(self.createFutureInt(from: 101),
                         self.createFutureString(from: 102),
                         self.createFutureBool(from: true),
                         self.createFutureInt(from: 121),
                         self.createFutureString(from: 122))
        DispatchQueue.global().async {
            let result = ⏱future
            XCTAssertEqual(result.successValue?.0, 101)
            XCTAssertEqual(result.successValue?.1, "102")
            XCTAssertEqual(result.successValue?.2, false)
            XCTAssertEqual(result.successValue?.3, 121)
            XCTAssertEqual(result.successValue?.4, "122")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - Lift
    
    func testAsyncOperationLift() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = lift(toFuture: self.createIntThrows(from:))("123")
        DispatchQueue.global().async {
            let result = ⏱future
            XCTAssertEqual(result.successValue, 123)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAsyncOperationLiftFailure() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = lift(toFuture: self.createIntThrows(from:))("Hello, World!")
        DispatchQueue.global().async {
            let result = ⏱future
            XCTAssertEqual(result.failureValue as? FutureError, FutureError.failedInt)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAsyncOperationLiftResult() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = lift(resultToFuture: self.createIntResult(from:))("123")
        DispatchQueue.global().async {
            let result = ⏱future
            XCTAssertEqual(result.successValue, 123)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAsyncOperationLiftResultFailure() {
        let expectation = XCTestExpectation(description: "Resolve value asynchronously.")
        let future = lift(resultToFuture: self.createIntResult(from:))("Hello, World!")
        DispatchQueue.global().async {
            let result = ⏱future
            XCTAssertEqual(result.failureValue as? FutureError, FutureError.failedInt)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    // MARK: - Create Future success functions
    
    func createFutureInt(from int: Int) -> Future<Int> {
        let promise = Promise<Int>()
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
            promise.resolve(value: int)
        }
        return promise
    }
    
    func createFutureIntClosure(from int: Int) -> Future<Int> {
        return Promise<Int>() { promise in
            promise.resolve(value: int, on: .main)
        }
    }
    
    func createFutureString(from int: Int) -> Future<String> {
        let promise = Promise<String>()
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
            promise.resolve(value: String(int))
        }
        return promise
    }
    
    func createFutureBool(from bool: Bool) -> Future<Bool> {
        let promise = Promise<Bool>()
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
            promise.resolve(value: !bool)
        }
        return promise
    }
    
    // MARK: - Create Future failure functions
    
    enum FutureError: Error, Equatable {
        case failedInt
        case failedString
        case failedBool
        public static func ==(lhs: FutureError, rhs: FutureError) -> Bool {
            switch (lhs, rhs) {
            case (.failedInt, .failedInt):
                return true
            case (.failedString, .failedString):
                return true
            case (.failedBool, .failedBool):
                return true
            default:
                return false
            }
        }
    }
    
    func createFutureIntFailure(from int: Int) -> Future<Int> {
        let promise = Promise<Int>()
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 0.1) {
            promise.reject(error: FutureError.failedInt)
        }
        return promise
    }
    
    func createFutureIntClosureFailure(from int: Int) -> Future<Int> {
        return Promise<Int>() { promise in
            promise.reject(error: FutureError.failedInt, on: .main)
        }
    }
    
    func createFutureStringFailure(from int: Int) -> Future<String> {
        let promise = Promise<String>()
        promise.reject(error: FutureError.failedString)
        return promise
    }
    
    func createFutureBoolFailure(from bool: Bool) -> Future<Bool> {
        let promise = Promise<Bool>()
        promise.reject(error: FutureError.failedBool)
        return promise
    }
    
    // MARK: Create Future non-monadic and Result functions
    
    func createIntThrows(from string: String) throws -> Int {
        guard let int = Int(string) else {
            throw FutureError.failedInt
        }
        return int
    }
    
    func createIntResult(from string: String) -> Result<Int> {
        guard let int = Int(string) else {
            return .failure(FutureError.failedInt)
        }
        return .success(int)
    }
    
}

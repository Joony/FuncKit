//
//  ResultTests.swift
//  FunKitTests
//
//  Created by Jonathan McAlister on 11/01/2018.
//  Copyright © 2018 FunKit. All rights reserved.
//

import XCTest
@testable import FunKit

class ResultTests: XCTestCase {
    
    // MARK: - Functor Laws
    
    // Functors must preserve identity morphisms
    func testFunctorPreserveIdentity() {
        let a = Result(101)
        let b = identity <^> Result(101)
        XCTAssertEqual(a.successValue, b.successValue)
    }
    
    /// Functors preserve composition of morphisms
    func testFunctorComposition() {
        let f = { (int: Int) in int + 10 }
        let g = { (int: Int) in int * 4 }
        let a = (f >>> g) <^> Result(101)
        let b = g <^> (f <^> Result(101))
        XCTAssertEqual(a.successValue, b.successValue)
    }
    
    // MARK: - Monad Laws
    
    // Left identity
    // (return v) >>= f ≡ f v
    func testMonadLeftIdentity() {
        let f = { (int: Int) in Result(int + 10) }
        let a = Result(101) >>= f
        let b = f(101)
        XCTAssertEqual(a.successValue, b.successValue)
    }
    
    // Right identity
    // m >>= return ≡ m
    func testMonadRightIdentity() {
        let a = Result(101) >>= Result.init
        let b = Result(101)
        XCTAssertEqual(a.successValue, b.successValue)
    }
    
    // Associativity
    // (m >>= f) >>= g ≡ m >>= ( \x -> (f x >>= g) )
    func testMonadAssociativity() {
        let f = { (int: Int) in Result(int + 10) }
        let g = { (int: Int) in Result(int * 4) }
        let a = (Result(101) >>= f) >>= g
        let b = Result(101) >>= { f($0) >>= g }
        XCTAssertEqual(a.successValue, b.successValue)
    }
    
    // MARK: - Applicative Laws
    
    // Identity
    // pure id <*> v = v
    func testApplicativeIdentity() {
        let a = Result(identity) <*> Result(101)
        let b = Result(101)
        XCTAssertEqual(a.successValue, b.successValue)
    }
    
    // Homomorphism
    // pure f <*> pure x = pure (f x)
    func testApplicativeHomomorphism() {
        let f = { (int: Int) in int + 10 }
        let a = Result(f) <*> Result(101)
        let b = Result(f(101))
        XCTAssertEqual(a.successValue, b.successValue)
    }
    
    // Interchange
    // u <*> pure y = pure ($ y) <*> u
    func testApplicativeInterchange() {
        func `$` <A, B>(a: A, f: (A) -> B) -> B { return f(a) }
        let f = { (int: Int) in int + 10 }
        let a = Result(f) <*> Result(101)
        let b = Result(curry(`$`)(101)) <*> Result(f)
        XCTAssertEqual(a.successValue, b.successValue)
    }
    
    // Composition
    // pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
    func testApplicativeComposition() {
        let f = { (int: Int) in int + 10 }
        let g = { (int: Int) in int * 4 }
        let a = Result(curry(<<<)) <*> Result(f) <*> Result(g) <*> Result(101)
        let b = Result(f) <*> (Result(g) <*> Result(101))
        XCTAssertEqual(a.successValue, b.successValue)
    }
    
    // MARK: - Test Result Success
    
    func testResultMap() {
        let result = self.createResultInt(from: 101)
        result.map { int in
            XCTAssertEqual(int, 101)
        }
    }
    
    func testResultFlatMap() {
        let result = self.createResultInt(from: 101) >>= self.createResultString(from:)
        result.map { string in
            XCTAssertEqual(string, "101")
        }
    }
    
    func testResultFlatMapKleisliComposition() {
        let result = self.createResultInt(from:) >=> self.createResultString(from:)
        let string = result(101)
        XCTAssertEqual(string.successValue, "101")
    }
    
    // MARK: - Test Result Failure
    
    func testResultMapFailure() {
        let result = self.createResultIntFailure(from: 101)
        XCTAssertEqual(result.failureValue as! ResultError, .failedInt)
    }
    
    func testResultFlatMapFailure() {
        let result = self.createResultIntFailure(from: 101) >>= self.createResultString(from:)
        XCTAssertEqual(result.failureValue as! ResultError, .failedInt)
    }
    
    func testResultFlatMapFailure2() {
        let result = self.createResultInt(from: 101) >>= self.createResultStringFailure(from:)
        XCTAssertEqual(result.failureValue as! ResultError, .failedString)
    }
    
    func testResultFlatMapKleisliCompositionFailure() {
        let f = self.createResultIntFailure(from:) >=> self.createResultString(from:)
        let result = f(101)
        XCTAssertEqual(result.failureValue as! ResultError, .failedInt)
    }
    
    func testResultFlatMapKleisliCompositionFailure2() {
        let f = self.createResultInt(from:) >=> self.createResultStringFailure(from:)
        let result = f(101)
        XCTAssertEqual(result.failureValue as! ResultError, .failedString)
    }
    
    // MARK: - Test Result Zip
    
    // ZIP is implemented in terms of Lift, and Lift is implemented in terms of Applicative, so if Zip works, it all works.
    
    func testResultZip2() {
        let result = zip(self.createResultInt(from: 101),
                         self.createResultString(from: 102))
        let (int, string) = result.successValue!
        XCTAssertEqual(int, 101)
        XCTAssertEqual(string, "102")
    }
    
    func testResultZip3() {
        let result = zip(self.createResultInt(from: 101),
                         self.createResultString(from: 102),
                         self.createResultBool(from: true))
        let (int, string, bool) = result.successValue!
        XCTAssertEqual(int, 101)
        XCTAssertEqual(string, "102")
        XCTAssertEqual(bool, false)
    }
    
    func testResultZip4() {
        let result = zip(self.createResultInt(from: 101),
                         self.createResultString(from: 102),
                         self.createResultBool(from: true),
                         self.createResultInt(from: 121))
        let (int, string, bool, int2) = result.successValue!
        XCTAssertEqual(int, 101)
        XCTAssertEqual(string, "102")
        XCTAssertEqual(bool, false)
        XCTAssertEqual(int2, 121)
    }
    
    func testResultZip5() {
        let result = zip(self.createResultInt(from: 101),
                         self.createResultString(from: 102),
                         self.createResultBool(from: true),
                         self.createResultInt(from: 121),
                         self.createResultString(from: 122))
        let (int, string, bool, int2, string2) = result.successValue!
        XCTAssertEqual(int, 101)
        XCTAssertEqual(string, "102")
        XCTAssertEqual(bool, false)
        XCTAssertEqual(int2, 121)
        XCTAssertEqual(string2, "122")
    }
    
    // MARK: - Test Result Optional
    
    func testResultOptionalSuccess() {
        let result = Result(101)
        XCTAssertEqual(result.successValue, 101)
    }
    
    func testResultOptionalSuccess2() {
        let result = Result<Int>.failure(ResultError.failedInt)
        XCTAssertNil(result.successValue)
    }
    
    func testResultOptionalFailure() {
        let result = Result<Int>.failure(ResultError.failedInt)
        XCTAssertEqual(result.failureValue! as! ResultError, .failedInt)
    }
    
    func testResultOptionalFailure2() {
        let result = Result(101)
        XCTAssertNil(result.failureValue)
    }
    
    // MARK: - Test Result Failure-coalescing
    
    func testResultFailureCoalescingSuccess() {
        let result = Result(101)
        XCTAssertEqual(result ?? 103, 101)
    }
    
    func testResultFailureCoalescingFailure() {
        let result = Result<Int>.failure(ResultError.failedInt)
        XCTAssertEqual(result ?? 103, 103)
    }
    
    func testResultFailureCoalescingSuccess2() {
        let result = Result(101)
        XCTAssertEqual((result ?? Result(103)).successValue, Result(101).successValue)
    }
    
    func testResultFailureCoalescingFailure2() {
        let result = Result<Int>.failure(ResultError.failedInt)
        XCTAssertEqual((result ?? Result(103)).successValue, Result(103).successValue)
    }
    
    // MARK: - Test Result Functions (lift and passthrough)
    
    func testResultLiftSuccess() {
        let result = lift(toResult: self.parse(string:))
        XCTAssertEqual(result("101").successValue, 101)
    }
    func testResultLiftFailure() {
        let result = lift(toResult: self.parse(string:))
        XCTAssertEqual(result("abc").failureValue as! ResultError, .failedString)
    }
    
    
    func testResultPassthrough() {
        let result = self.createResultInt(from:) >=>
            passthrough({
                XCTAssertEqual($0, 101)
            }) >=>
            self.createResultString(from:)
        XCTAssertEqual(result(101).successValue, "101")
    }
    
    // MARK: - Create Result success functions
    
    func createResultInt(from int: Int) -> Result<Int> {
        return Result(int)
    }
    
    func createResultString(from int: Int) -> Result<String> {
        return Result(String(int))
    }
    
    func createResultBool(from bool: Bool) -> Result<Bool> {
        return Result(!bool)
    }
    
    // MARK: - Create Result failure functions
    
    enum ResultError: Error, Equatable {
        case failedInt
        case failedString
        case failedBool
        public static func ==(lhs: ResultError, rhs: ResultError) -> Bool {
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
    
    func createResultIntFailure(from int: Int) -> Result<Int> {
        return Result.failure(ResultError.failedInt)
    }
    
    func createResultStringFailure(from int: Int) -> Result<String> {
        return Result.failure(ResultError.failedString)
    }
    
    func createResultBoolFailure(from bool: Bool) -> Result<Bool> {
        return Result.failure(ResultError.failedBool)
    }
    
    // MARK: - Non-monadic functions
    
    func parse(string: String) throws -> Int {
        guard let int = Int(string) else {
            throw ResultError.failedString
        }
        return int
    }
    
}

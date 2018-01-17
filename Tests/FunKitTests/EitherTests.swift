//
//  EitherTests.swift
//  FunKitTests
//
//  Created by Jonathan McAlister on 12/01/2018.
//  Copyright © 2018 FunKit. All rights reserved.
//

import XCTest
@testable import FunKit

class EitherTests: XCTestCase {
    
    func testFirstLeft() {
        let either = Either<Int, String>.left(101)
        let firstResult = either.first { int in String(int) }
        if case let .left(string) = firstResult {
            XCTAssertEqual(string, "101")
        } else {
            XCTFail()
        }
    }
    
    func testFirstRight() {
        let either = Either<Int, String>.right("Hello")
        let firstResult = either.first { int in String(int) }
        if case let .right(string) = firstResult {
            XCTAssertEqual(string, "Hello")
        } else {
            XCTFail()
        }
    }
    
    func testSecondRight() {
        let either = Either<Int, String>.right("Hello")
        let firstResult = either.second { string in string + ", World!" }
        if case let .right(string) = firstResult {
            XCTAssertEqual(string, "Hello, World!")
        } else {
            XCTFail()
        }
    }
    
    func testSecondLeft() {
        let either = Either<Int, String>.left(101)
        let firstResult = either.second { int in String(int) }
        if case let .left(int) = firstResult {
            XCTAssertEqual(int, 101)
        } else {
            XCTFail()
        }
    }
    
}

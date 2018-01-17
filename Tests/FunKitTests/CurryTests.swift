//
//  CurryTests.swift
//  FunKitTests
//
//  Created by Jonathan McAlister on 12/01/2018.
//  Copyright © 2018 FunKit. All rights reserved.
//

import XCTest
@testable import FunKit

class CurryTests: XCTestCase {
    
    // MARK: - Curry
    
    func testCurry2() {
        let curried = curry(self.test2)
        let a = curried(101)("Hello")
        let b = self.test2(int: 101, string: "Hello")
        XCTAssertEqual(a, b)
    }
    
    func testCurry3() {
        let curried = curry(self.test3)
        let a = curried(101)("Hello")(true)
        let b = self.test3(int: 101, string: "Hello", bool: true)
        XCTAssertEqual(a, b)
    }
    
    func testCurry4() {
        let curried = curry(self.test4)
        let a = curried(101)("Hello")(true)([true, false])
        let b = self.test4(int: 101, string: "Hello", bool: true, list: [true, false])
        XCTAssertEqual(a, b)
    }
    
    func testCurry5() {
        let curried = curry(self.test5)
        let a = curried(101)("Hello")(true)([true, false])(1.3)
        let b = self.test5(int: 101, string: "Hello", bool: true, list: [true, false], float: 1.3)
        XCTAssertEqual(a, b)
    }
    
    // MARK: - CurryR
    
    func testCurryR2() {
        let curried = curryr(self.test2)
        let a = curried("Hello")(101)
        let b = self.test2(int: 101, string: "Hello")
        XCTAssertEqual(a, b)
    }
    
    func testCurryR3() {
        let curried = curryr(self.test3)
        let a = curried(true)("Hello")(101)
        let b = self.test3(int: 101, string: "Hello", bool: true)
        XCTAssertEqual(a, b)
    }
    
    func testCurryR4() {
        let curried = curryr(self.test4)
        let a = curried([true, false])(true)("Hello")(101)
        let b = self.test4(int: 101, string: "Hello", bool: true, list: [true, false])
        XCTAssertEqual(a, b)
    }
    
    func testCurryR5() {
        let curried = curryr(self.test5)
        let a = curried(1.3)([true, false])(true)("Hello")(101)
        let b = self.test5(int: 101, string: "Hello", bool: true, list: [true, false], float: 1.3)
        XCTAssertEqual(a, b)
    }
    
    // MARK: - Test functions
    
    func test2(int: Int, string: String) -> String {
        return "\(int), \(string)"
    }
    
    func test3(int: Int, string: String, bool: Bool) -> String {
        return "\(int), \(string), \(bool)"
    }
    
    func test4(int: Int, string: String, bool: Bool, list: [Bool]) -> String {
        return "\(int), \(string), \(bool), \(list)"
    }
    
    func test5(int: Int, string: String, bool: Bool, list: [Bool], float: Float) -> String {
        return "\(int), \(string), \(bool), \(list), \(float)"
    }
    
}

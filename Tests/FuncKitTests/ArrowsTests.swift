//
//  ArrowsTests.swift
//  FunKitTests
//
//  Created by Jonathan McAlister on 12/01/2018.
//  Copyright © 2018 FunKit. All rights reserved.
//

import XCTest
@testable import FuncKit

class ArrowsTests: XCTestCase {
    
    // MARK: - Fanin
    
    func testFaninLeft() {
        let input = Either<Int, Int>.left(101)
        let left = { (a: Int) in a * 2 }
        let right = { (b: Int) in b - 2 }
        let fanin = left ||| right
        let a = fanin(input)
        let b = 202
        XCTAssertEqual(a, b)
    }
    
    func testFaninRight() {
        let input = Either<Int, Int>.right(101)
        let left = { (a: Int) in a * 2 }
        let right = { (b: Int) in b - 2 }
        let fanin = left ||| right
        let a = fanin(input)
        let b = 99
        XCTAssertEqual(a, b)
    }
    
    // MARK: - Fanout
    
    func testFanOut() {
        let left = { (a: Int) in a * 2 }
        let right = { (b: Int) in String(b) }
        let fanout = left &&& right
        let a = fanout(101)
        XCTAssertEqual(a.0, 202)
        XCTAssertEqual(a.1, "101")
    }
    
    // MARK: - Splat
    
    func testSplatLeft() {
        let input = Either<Int, String>.left(101)
        let left = { (a: Int) in a * 2 }
        let right = { (b: String) in b + ", World!" }
        let splat = left +++ right
        let a = splat(input)
        let b = 202
        
        guard case let .left(int) = a else {
            return XCTFail()
        }
        XCTAssertEqual(int, b)
    }
    
    func testSplatRight() {
        let input = Either<Int, String>.right("Hello")
        let left = { (a: Int) in a * 2 }
        let right = { (b: String) in b + ", World!" }
        let splat = left +++ right
        let a = splat(input)
        let b = "Hello, World!"
        
        guard case let .right(string) = a else {
            return XCTFail()
        }
        XCTAssertEqual(string, b)
    }
    
    // MARK: - Split
    
    func testSplit() {
        let a = 101
        let aa = split(a)
        XCTAssertEqual(aa.0, (101, 101).0)
        XCTAssertEqual(aa.1, (101, 101).1)
    }
    
    func testSplitOperator() {
        let left = { (a: Int) in a * 2 }
        let right = { (b: String) in b + ", World!" }
        let split = left *** right
        let a = split(101, "Hello")
        let b = (202, "Hello, World!")
        XCTAssertEqual(a.0, b.0)
        XCTAssertEqual(a.1, b.1)
    }
    
    // MARK: First/Second
    
    func testFirst() {
        let f = { (a: Int) in String(a) }
        let firstF: (Int, String) -> (String, String) = first(f)
        let a = firstF(101, "Hello")
        let b = ("101", "Hello")
        XCTAssertEqual(a.0, b.0)
        XCTAssertEqual(a.1, b.1)
    }
    
    func testSecond() {
        let f = { (a: String) in a + ", World!" }
        let secondF: (Int, String) -> (Int, String) = second(f)
        let a = secondF(101, "Hello")
        let b = (101, "Hello, World!")
        XCTAssertEqual(a.0, b.0)
        XCTAssertEqual(a.1, b.1)
    }
    
    // MARK: Function Composition
    
    func testFunctionCompositionRight() {
        let f = { (a: Int) in a * 2 }
        let g = { (b: Int) in b + 10 }
        let h = { (c: Int) in c - 2 }
        let fgh0 = f >>> g >>> h
        let fgh1 = (f >>> g) >>> h
        let fgh2 = f >>> (g >>> h)
        XCTAssertEqual(fgh0(101), 210)
        XCTAssertEqual(fgh1(101), 210)
        XCTAssertEqual(fgh2(101), 210)
    }
    
    func testFunctionCompositionLeft() {
        let f = { (a: Int) in a * 2 }
        let g = { (b: Int) in b + 10 }
        let h = { (c: Int) in c - 2 }
        let fgh0 = h <<< g <<< f
        let fgh1 = (h <<< g) <<< f
        let fgh2 = h <<< (g <<< f)
        XCTAssertEqual(fgh0(101), 210)
        XCTAssertEqual(fgh1(101), 210)
        XCTAssertEqual(fgh2(101), 210)
    }
    
}

//
//  PapplyrTests.swift
//  FunKitTests
//
//  Created by Jonathan McAllister on 16/01/2018.
//  Copyright © 2018 FunKit. All rights reserved.
//

import XCTest
@testable import FuncKit

class PapplyrTests: XCTestCase {
    
    func testPapplyr0() {
        // 1, 1, 0, []
        let f = papplyr(201, f: { (a: Int) in return "\(a)" } )
        let a = f()
        let b = "201"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr1() {
        // 1, 1, 1, [0]
        let test0 = Test(int: 100)
        let f = papplyr(test0, f: { (a: Test) in return "\(a.int)" } )
        let a = f()
        let b = "100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr2() {
        // 2, 1, 0, []
        let f = papplyr("202", f: { (a: Int, b: String) in return "\(a), \(b)" } )
        let a = f(201)
        let b = "201, 202"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr3() {
        // 2, 1, 1, [1]
        let test0 = Test(int: 100)
        let f = papplyr(test0, f: { (a: Int, b: Test) in return "\(a), \(b.int)" } )
        let a = f(201)
        let b = "201, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr4() {
        // 2, 2, 0, []
        let f = papplyr(201, "202", f: { (a: Int, b: String) in return "\(a), \(b)" } )
        let a = f()
        let b = "201, 202"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr5() {
        // 2, 2, 1, [0]
        let test0 = Test(int: 100)
        let f = papplyr(test0, "202", f: { (a: Test, b: String) in return "\(a.int), \(b)" } )
        let a = f()
        let b = "100, 202"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr6() {
        // 2, 2, 1, [1]
        let test0 = Test(int: 100)
        let f = papplyr(201, test0, f: { (a: Int, b: Test) in return "\(a), \(b.int)" } )
        let a = f()
        let b = "201, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr7() {
        // 2, 2, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, test1, f: { (a: Test, b: Test) in return "\(a.int), \(b.int)" } )
        let a = f()
        let b = "100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr8() {
        // 3, 1, 0, []
        let f = papplyr(true, f: { (a: Int, b: String, c: Bool) in return "\(a), \(b), \(c)" } )
        let a = f(201, "202")
        let b = "201, 202, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr9() {
        // 3, 1, 1, [2]
        let test0 = Test(int: 100)
        let f = papplyr(test0, f: { (a: Int, b: String, c: Test) in return "\(a), \(b), \(c.int)" } )
        let a = f(201, "202")
        let b = "201, 202, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr10() {
        // 3, 2, 0, []
        let f = papplyr("202", true, f: { (a: Int, b: String, c: Bool) in return "\(a), \(b), \(c)" } )
        let a = f(201)
        let b = "201, 202, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr11() {
        // 3, 2, 1, [1]
        let test0 = Test(int: 100)
        let f = papplyr(test0, true, f: { (a: Int, b: Test, c: Bool) in return "\(a), \(b.int), \(c)" } )
        let a = f(201)
        let b = "201, 100, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr12() {
        // 3, 2, 1, [2]
        let test0 = Test(int: 100)
        let f = papplyr("202", test0, f: { (a: Int, b: String, c: Test) in return "\(a), \(b), \(c.int)" } )
        let a = f(201)
        let b = "201, 202, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr13() {
        // 3, 2, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, test1, f: { (a: Int, b: Test, c: Test) in return "\(a), \(b.int), \(c.int)" } )
        let a = f(201)
        let b = "201, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr14() {
        // 3, 3, 0, []
        let f = papplyr(201, "202", true, f: { (a: Int, b: String, c: Bool) in return "\(a), \(b), \(c)" } )
        let a = f()
        let b = "201, 202, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr15() {
        // 3, 3, 1, [0]
        let test0 = Test(int: 100)
        let f = papplyr(test0, "202", true, f: { (a: Test, b: String, c: Bool) in return "\(a.int), \(b), \(c)" } )
        let a = f()
        let b = "100, 202, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr16() {
        // 3, 3, 1, [1]
        let test0 = Test(int: 100)
        let f = papplyr(201, test0, true, f: { (a: Int, b: Test, c: Bool) in return "\(a), \(b.int), \(c)" } )
        let a = f()
        let b = "201, 100, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr17() {
        // 3, 3, 1, [2]
        let test0 = Test(int: 100)
        let f = papplyr(201, "202", test0, f: { (a: Int, b: String, c: Test) in return "\(a), \(b), \(c.int)" } )
        let a = f()
        let b = "201, 202, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr18() {
        // 3, 3, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, test1, true, f: { (a: Test, b: Test, c: Bool) in return "\(a.int), \(b.int), \(c)" } )
        let a = f()
        let b = "100, 101, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr19() {
        // 3, 3, 2, [0, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, "202", test1, f: { (a: Test, b: String, c: Test) in return "\(a.int), \(b), \(c.int)" } )
        let a = f()
        let b = "100, 202, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr20() {
        // 3, 3, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(201, test0, test1, f: { (a: Int, b: Test, c: Test) in return "\(a), \(b.int), \(c.int)" } )
        let a = f()
        let b = "201, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr21() {
        // 3, 3, 3, [0, 1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, test1, test2, f: { (a: Test, b: Test, c: Test) in return "\(a.int), \(b.int), \(c.int)" } )
        let a = f()
        let b = "100, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr22() {
        // 4, 1, 0, []
        let f = papplyr([false, true], f: { (a: Int, b: String, c: Bool, d: [Bool]) in return "\(a), \(b), \(c), \(d)" } )
        let a = f(201, "202", true)
        let b = "201, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr23() {
        // 4, 1, 1, [3]
        let test0 = Test(int: 100)
        let f = papplyr(test0, f: { (a: Int, b: String, c: Bool, d: Test) in return "\(a), \(b), \(c), \(d.int)" } )
        let a = f(201, "202", true)
        let b = "201, 202, true, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr24() {
        // 4, 2, 0, []
        let f = papplyr(true, [false, true], f: { (a: Int, b: String, c: Bool, d: [Bool]) in return "\(a), \(b), \(c), \(d)" } )
        let a = f(201, "202")
        let b = "201, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr25() {
        // 4, 2, 1, [2]
        let test0 = Test(int: 100)
        let f = papplyr(test0, [false, true], f: { (a: Int, b: String, c: Test, d: [Bool]) in return "\(a), \(b), \(c.int), \(d)" } )
        let a = f(201, "202")
        let b = "201, 202, 100, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr26() {
        // 4, 2, 1, [3]
        let test0 = Test(int: 100)
        let f = papplyr(true, test0, f: { (a: Int, b: String, c: Bool, d: Test) in return "\(a), \(b), \(c), \(d.int)" } )
        let a = f(201, "202")
        let b = "201, 202, true, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr27() {
        // 4, 2, 2, [2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, test1, f: { (a: Int, b: String, c: Test, d: Test) in return "\(a), \(b), \(c.int), \(d.int)" } )
        let a = f(201, "202")
        let b = "201, 202, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr28() {
        // 4, 3, 0, []
        let f = papplyr("202", true, [false, true], f: { (a: Int, b: String, c: Bool, d: [Bool]) in return "\(a), \(b), \(c), \(d)" } )
        let a = f(201)
        let b = "201, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr29() {
        // 4, 3, 1, [1]
        let test0 = Test(int: 100)
        let f = papplyr(test0, true, [false, true], f: { (a: Int, b: Test, c: Bool, d: [Bool]) in return "\(a), \(b.int), \(c), \(d)" } )
        let a = f(201)
        let b = "201, 100, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr30() {
        // 4, 3, 1, [2]
        let test0 = Test(int: 100)
        let f = papplyr("202", test0, [false, true], f: { (a: Int, b: String, c: Test, d: [Bool]) in return "\(a), \(b), \(c.int), \(d)" } )
        let a = f(201)
        let b = "201, 202, 100, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr31() {
        // 4, 3, 1, [3]
        let test0 = Test(int: 100)
        let f = papplyr("202", true, test0, f: { (a: Int, b: String, c: Bool, d: Test) in return "\(a), \(b), \(c), \(d.int)" } )
        let a = f(201)
        let b = "201, 202, true, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr32() {
        // 4, 3, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, test1, [false, true], f: { (a: Int, b: Test, c: Test, d: [Bool]) in return "\(a), \(b.int), \(c.int), \(d)" } )
        let a = f(201)
        let b = "201, 100, 101, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr33() {
        // 4, 3, 2, [1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, true, test1, f: { (a: Int, b: Test, c: Bool, d: Test) in return "\(a), \(b.int), \(c), \(d.int)" } )
        let a = f(201)
        let b = "201, 100, true, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr34() {
        // 4, 3, 2, [2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr("202", test0, test1, f: { (a: Int, b: String, c: Test, d: Test) in return "\(a), \(b), \(c.int), \(d.int)" } )
        let a = f(201)
        let b = "201, 202, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr35() {
        // 4, 3, 3, [1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, test1, test2, f: { (a: Int, b: Test, c: Test, d: Test) in return "\(a), \(b.int), \(c.int), \(d.int)" } )
        let a = f(201)
        let b = "201, 100, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr36() {
        // 4, 4, 0, []
        let f = papplyr(201, "202", true, [false, true], f: { (a: Int, b: String, c: Bool, d: [Bool]) in return "\(a), \(b), \(c), \(d)" } )
        let a = f()
        let b = "201, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr37() {
        // 4, 4, 1, [0]
        let test0 = Test(int: 100)
        let f = papplyr(test0, "202", true, [false, true], f: { (a: Test, b: String, c: Bool, d: [Bool]) in return "\(a.int), \(b), \(c), \(d)" } )
        let a = f()
        let b = "100, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr38() {
        // 4, 4, 1, [1]
        let test0 = Test(int: 100)
        let f = papplyr(201, test0, true, [false, true], f: { (a: Int, b: Test, c: Bool, d: [Bool]) in return "\(a), \(b.int), \(c), \(d)" } )
        let a = f()
        let b = "201, 100, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr39() {
        // 4, 4, 1, [2]
        let test0 = Test(int: 100)
        let f = papplyr(201, "202", test0, [false, true], f: { (a: Int, b: String, c: Test, d: [Bool]) in return "\(a), \(b), \(c.int), \(d)" } )
        let a = f()
        let b = "201, 202, 100, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr40() {
        // 4, 4, 1, [3]
        let test0 = Test(int: 100)
        let f = papplyr(201, "202", true, test0, f: { (a: Int, b: String, c: Bool, d: Test) in return "\(a), \(b), \(c), \(d.int)" } )
        let a = f()
        let b = "201, 202, true, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr41() {
        // 4, 4, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, test1, true, [false, true], f: { (a: Test, b: Test, c: Bool, d: [Bool]) in return "\(a.int), \(b.int), \(c), \(d)" } )
        let a = f()
        let b = "100, 101, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr42() {
        // 4, 4, 2, [0, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, "202", test1, [false, true], f: { (a: Test, b: String, c: Test, d: [Bool]) in return "\(a.int), \(b), \(c.int), \(d)" } )
        let a = f()
        let b = "100, 202, 101, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr43() {
        // 4, 4, 2, [0, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, "202", true, test1, f: { (a: Test, b: String, c: Bool, d: Test) in return "\(a.int), \(b), \(c), \(d.int)" } )
        let a = f()
        let b = "100, 202, true, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr44() {
        // 4, 4, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(201, test0, test1, [false, true], f: { (a: Int, b: Test, c: Test, d: [Bool]) in return "\(a), \(b.int), \(c.int), \(d)" } )
        let a = f()
        let b = "201, 100, 101, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr45() {
        // 4, 4, 2, [1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(201, test0, true, test1, f: { (a: Int, b: Test, c: Bool, d: Test) in return "\(a), \(b.int), \(c), \(d.int)" } )
        let a = f()
        let b = "201, 100, true, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr46() {
        // 4, 4, 2, [2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(201, "202", test0, test1, f: { (a: Int, b: String, c: Test, d: Test) in return "\(a), \(b), \(c.int), \(d.int)" } )
        let a = f()
        let b = "201, 202, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr47() {
        // 4, 4, 3, [0, 1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, test1, test2, [false, true], f: { (a: Test, b: Test, c: Test, d: [Bool]) in return "\(a.int), \(b.int), \(c.int), \(d)" } )
        let a = f()
        let b = "100, 101, 102, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr48() {
        // 4, 4, 3, [0, 1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, test1, true, test2, f: { (a: Test, b: Test, c: Bool, d: Test) in return "\(a.int), \(b.int), \(c), \(d.int)" } )
        let a = f()
        let b = "100, 101, true, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr49() {
        // 4, 4, 3, [0, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, "202", test1, test2, f: { (a: Test, b: String, c: Test, d: Test) in return "\(a.int), \(b), \(c.int), \(d.int)" } )
        let a = f()
        let b = "100, 202, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr50() {
        // 4, 4, 3, [1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(201, test0, test1, test2, f: { (a: Int, b: Test, c: Test, d: Test) in return "\(a), \(b.int), \(c.int), \(d.int)" } )
        let a = f()
        let b = "201, 100, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr51() {
        // 4, 4, 4, [0, 1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papplyr(test0, test1, test2, test3, f: { (a: Test, b: Test, c: Test, d: Test) in return "\(a.int), \(b.int), \(c.int), \(d.int)" } )
        let a = f()
        let b = "100, 101, 102, 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr52() {
        // 5, 1, 0, []
        let f = papplyr(1.2, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Float) in return "\(a), \(b), \(c), \(d), \(e)" } )
        let a = f(201, "202", true, [false, true])
        let b = "201, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr53() {
        // 5, 1, 1, [4]
        let test0 = Test(int: 100)
        let f = papplyr(test0, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Test) in return "\(a), \(b), \(c), \(d), \(e.int)" } )
        let a = f(201, "202", true, [false, true])
        let b = "201, 202, true, [false, true], 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr54() {
        // 5, 2, 0, []
        let f = papplyr([false, true], 1.2, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Float) in return "\(a), \(b), \(c), \(d), \(e)" } )
        let a = f(201, "202", true)
        let b = "201, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr55() {
        // 5, 2, 1, [3]
        let test0 = Test(int: 100)
        let f = papplyr(test0, 1.2, f: { (a: Int, b: String, c: Bool, d: Test, e: Float) in return "\(a), \(b), \(c), \(d.int), \(e)" } )
        let a = f(201, "202", true)
        let b = "201, 202, true, 100, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr56() {
        // 5, 2, 1, [4]
        let test0 = Test(int: 100)
        let f = papplyr([false, true], test0, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Test) in return "\(a), \(b), \(c), \(d), \(e.int)" } )
        let a = f(201, "202", true)
        let b = "201, 202, true, [false, true], 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr57() {
        // 5, 2, 2, [3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, test1, f: { (a: Int, b: String, c: Bool, d: Test, e: Test) in return "\(a), \(b), \(c), \(d.int), \(e.int)" } )
        let a = f(201, "202", true)
        let b = "201, 202, true, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr58() {
        // 5, 3, 0, []
        let f = papplyr(true, [false, true], 1.2, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Float) in return "\(a), \(b), \(c), \(d), \(e)" } )
        let a = f(201, "202")
        let b = "201, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr59() {
        // 5, 3, 1, [2]
        let test0 = Test(int: 100)
        let f = papplyr(test0, [false, true], 1.2, f: { (a: Int, b: String, c: Test, d: [Bool], e: Float) in return "\(a), \(b), \(c.int), \(d), \(e)" } )
        let a = f(201, "202")
        let b = "201, 202, 100, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr60() {
        // 5, 3, 1, [3]
        let test0 = Test(int: 100)
        let f = papplyr(true, test0, 1.2, f: { (a: Int, b: String, c: Bool, d: Test, e: Float) in return "\(a), \(b), \(c), \(d.int), \(e)" } )
        let a = f(201, "202")
        let b = "201, 202, true, 100, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr61() {
        // 5, 3, 1, [4]
        let test0 = Test(int: 100)
        let f = papplyr(true, [false, true], test0, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Test) in return "\(a), \(b), \(c), \(d), \(e.int)" } )
        let a = f(201, "202")
        let b = "201, 202, true, [false, true], 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr62() {
        // 5, 3, 2, [2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, test1, 1.2, f: { (a: Int, b: String, c: Test, d: Test, e: Float) in return "\(a), \(b), \(c.int), \(d.int), \(e)" } )
        let a = f(201, "202")
        let b = "201, 202, 100, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr63() {
        // 5, 3, 2, [2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, [false, true], test1, f: { (a: Int, b: String, c: Test, d: [Bool], e: Test) in return "\(a), \(b), \(c.int), \(d), \(e.int)" } )
        let a = f(201, "202")
        let b = "201, 202, 100, [false, true], 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr64() {
        // 5, 3, 2, [3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(true, test0, test1, f: { (a: Int, b: String, c: Bool, d: Test, e: Test) in return "\(a), \(b), \(c), \(d.int), \(e.int)" } )
        let a = f(201, "202")
        let b = "201, 202, true, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr65() {
        // 5, 3, 3, [2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, test1, test2, f: { (a: Int, b: String, c: Test, d: Test, e: Test) in return "\(a), \(b), \(c.int), \(d.int), \(e.int)" } )
        let a = f(201, "202")
        let b = "201, 202, 100, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr66() {
        // 5, 4, 0, []
        let f = papplyr("202", true, [false, true], 1.2, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Float) in return "\(a), \(b), \(c), \(d), \(e)" } )
        let a = f(201)
        let b = "201, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr67() {
        // 5, 4, 1, [1]
        let test0 = Test(int: 100)
        let f = papplyr(test0, true, [false, true], 1.2, f: { (a: Int, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a), \(b.int), \(c), \(d), \(e)" } )
        let a = f(201)
        let b = "201, 100, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr68() {
        // 5, 4, 1, [2]
        let test0 = Test(int: 100)
        let f = papplyr("202", test0, [false, true], 1.2, f: { (a: Int, b: String, c: Test, d: [Bool], e: Float) in return "\(a), \(b), \(c.int), \(d), \(e)" } )
        let a = f(201)
        let b = "201, 202, 100, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr69() {
        // 5, 4, 1, [3]
        let test0 = Test(int: 100)
        let f = papplyr("202", true, test0, 1.2, f: { (a: Int, b: String, c: Bool, d: Test, e: Float) in return "\(a), \(b), \(c), \(d.int), \(e)" } )
        let a = f(201)
        let b = "201, 202, true, 100, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr70() {
        // 5, 4, 1, [4]
        let test0 = Test(int: 100)
        let f = papplyr("202", true, [false, true], test0, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Test) in return "\(a), \(b), \(c), \(d), \(e.int)" } )
        let a = f(201)
        let b = "201, 202, true, [false, true], 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr71() {
        // 5, 4, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, test1, [false, true], 1.2, f: { (a: Int, b: Test, c: Test, d: [Bool], e: Float) in return "\(a), \(b.int), \(c.int), \(d), \(e)" } )
        let a = f(201)
        let b = "201, 100, 101, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr72() {
        // 5, 4, 2, [1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, true, test1, 1.2, f: { (a: Int, b: Test, c: Bool, d: Test, e: Float) in return "\(a), \(b.int), \(c), \(d.int), \(e)" } )
        let a = f(201)
        let b = "201, 100, true, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr73() {
        // 5, 4, 2, [1, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, true, [false, true], test1, f: { (a: Int, b: Test, c: Bool, d: [Bool], e: Test) in return "\(a), \(b.int), \(c), \(d), \(e.int)" } )
        let a = f(201)
        let b = "201, 100, true, [false, true], 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr74() {
        // 5, 4, 2, [2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr("202", test0, test1, 1.2, f: { (a: Int, b: String, c: Test, d: Test, e: Float) in return "\(a), \(b), \(c.int), \(d.int), \(e)" } )
        let a = f(201)
        let b = "201, 202, 100, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr75() {
        // 5, 4, 2, [2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr("202", test0, [false, true], test1, f: { (a: Int, b: String, c: Test, d: [Bool], e: Test) in return "\(a), \(b), \(c.int), \(d), \(e.int)" } )
        let a = f(201)
        let b = "201, 202, 100, [false, true], 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr76() {
        // 5, 4, 2, [3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr("202", true, test0, test1, f: { (a: Int, b: String, c: Bool, d: Test, e: Test) in return "\(a), \(b), \(c), \(d.int), \(e.int)" } )
        let a = f(201)
        let b = "201, 202, true, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr77() {
        // 5, 4, 3, [1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, test1, test2, 1.2, f: { (a: Int, b: Test, c: Test, d: Test, e: Float) in return "\(a), \(b.int), \(c.int), \(d.int), \(e)" } )
        let a = f(201)
        let b = "201, 100, 101, 102, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr78() {
        // 5, 4, 3, [1, 2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, test1, [false, true], test2, f: { (a: Int, b: Test, c: Test, d: [Bool], e: Test) in return "\(a), \(b.int), \(c.int), \(d), \(e.int)" } )
        let a = f(201)
        let b = "201, 100, 101, [false, true], 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr79() {
        // 5, 4, 3, [1, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, true, test1, test2, f: { (a: Int, b: Test, c: Bool, d: Test, e: Test) in return "\(a), \(b.int), \(c), \(d.int), \(e.int)" } )
        let a = f(201)
        let b = "201, 100, true, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr80() {
        // 5, 4, 3, [2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr("202", test0, test1, test2, f: { (a: Int, b: String, c: Test, d: Test, e: Test) in return "\(a), \(b), \(c.int), \(d.int), \(e.int)" } )
        let a = f(201)
        let b = "201, 202, 100, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr81() {
        // 5, 4, 4, [1, 2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papplyr(test0, test1, test2, test3, f: { (a: Int, b: Test, c: Test, d: Test, e: Test) in return "\(a), \(b.int), \(c.int), \(d.int), \(e.int)" } )
        let a = f(201)
        let b = "201, 100, 101, 102, 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr82() {
        // 5, 5, 0, []
        let f = papplyr(201, "202", true, [false, true], 1.2, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Float) in return "\(a), \(b), \(c), \(d), \(e)" } )
        let a = f()
        let b = "201, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr83() {
        // 5, 5, 1, [0]
        let test0 = Test(int: 100)
        let f = papplyr(test0, "202", true, [false, true], 1.2, f: { (a: Test, b: String, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b), \(c), \(d), \(e)" } )
        let a = f()
        let b = "100, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr84() {
        // 5, 5, 1, [1]
        let test0 = Test(int: 100)
        let f = papplyr(201, test0, true, [false, true], 1.2, f: { (a: Int, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a), \(b.int), \(c), \(d), \(e)" } )
        let a = f()
        let b = "201, 100, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr85() {
        // 5, 5, 1, [2]
        let test0 = Test(int: 100)
        let f = papplyr(201, "202", test0, [false, true], 1.2, f: { (a: Int, b: String, c: Test, d: [Bool], e: Float) in return "\(a), \(b), \(c.int), \(d), \(e)" } )
        let a = f()
        let b = "201, 202, 100, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr86() {
        // 5, 5, 1, [3]
        let test0 = Test(int: 100)
        let f = papplyr(201, "202", true, test0, 1.2, f: { (a: Int, b: String, c: Bool, d: Test, e: Float) in return "\(a), \(b), \(c), \(d.int), \(e)" } )
        let a = f()
        let b = "201, 202, true, 100, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr87() {
        // 5, 5, 1, [4]
        let test0 = Test(int: 100)
        let f = papplyr(201, "202", true, [false, true], test0, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Test) in return "\(a), \(b), \(c), \(d), \(e.int)" } )
        let a = f()
        let b = "201, 202, true, [false, true], 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr88() {
        // 5, 5, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, test1, true, [false, true], 1.2, f: { (a: Test, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b.int), \(c), \(d), \(e)" } )
        let a = f()
        let b = "100, 101, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr89() {
        // 5, 5, 2, [0, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, "202", test1, [false, true], 1.2, f: { (a: Test, b: String, c: Test, d: [Bool], e: Float) in return "\(a.int), \(b), \(c.int), \(d), \(e)" } )
        let a = f()
        let b = "100, 202, 101, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr90() {
        // 5, 5, 2, [0, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, "202", true, test1, 1.2, f: { (a: Test, b: String, c: Bool, d: Test, e: Float) in return "\(a.int), \(b), \(c), \(d.int), \(e)" } )
        let a = f()
        let b = "100, 202, true, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr91() {
        // 5, 5, 2, [0, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(test0, "202", true, [false, true], test1, f: { (a: Test, b: String, c: Bool, d: [Bool], e: Test) in return "\(a.int), \(b), \(c), \(d), \(e.int)" } )
        let a = f()
        let b = "100, 202, true, [false, true], 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr92() {
        // 5, 5, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(201, test0, test1, [false, true], 1.2, f: { (a: Int, b: Test, c: Test, d: [Bool], e: Float) in return "\(a), \(b.int), \(c.int), \(d), \(e)" } )
        let a = f()
        let b = "201, 100, 101, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr93() {
        // 5, 5, 2, [1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(201, test0, true, test1, 1.2, f: { (a: Int, b: Test, c: Bool, d: Test, e: Float) in return "\(a), \(b.int), \(c), \(d.int), \(e)" } )
        let a = f()
        let b = "201, 100, true, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr94() {
        // 5, 5, 2, [1, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(201, test0, true, [false, true], test1, f: { (a: Int, b: Test, c: Bool, d: [Bool], e: Test) in return "\(a), \(b.int), \(c), \(d), \(e.int)" } )
        let a = f()
        let b = "201, 100, true, [false, true], 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr95() {
        // 5, 5, 2, [2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(201, "202", test0, test1, 1.2, f: { (a: Int, b: String, c: Test, d: Test, e: Float) in return "\(a), \(b), \(c.int), \(d.int), \(e)" } )
        let a = f()
        let b = "201, 202, 100, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr96() {
        // 5, 5, 2, [2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(201, "202", test0, [false, true], test1, f: { (a: Int, b: String, c: Test, d: [Bool], e: Test) in return "\(a), \(b), \(c.int), \(d), \(e.int)" } )
        let a = f()
        let b = "201, 202, 100, [false, true], 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr97() {
        // 5, 5, 2, [3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papplyr(201, "202", true, test0, test1, f: { (a: Int, b: String, c: Bool, d: Test, e: Test) in return "\(a), \(b), \(c), \(d.int), \(e.int)" } )
        let a = f()
        let b = "201, 202, true, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr98() {
        // 5, 5, 3, [0, 1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, test1, test2, [false, true], 1.2, f: { (a: Test, b: Test, c: Test, d: [Bool], e: Float) in return "\(a.int), \(b.int), \(c.int), \(d), \(e)" } )
        let a = f()
        let b = "100, 101, 102, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr99() {
        // 5, 5, 3, [0, 1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, test1, true, test2, 1.2, f: { (a: Test, b: Test, c: Bool, d: Test, e: Float) in return "\(a.int), \(b.int), \(c), \(d.int), \(e)" } )
        let a = f()
        let b = "100, 101, true, 102, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr100() {
        // 5, 5, 3, [0, 1, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, test1, true, [false, true], test2, f: { (a: Test, b: Test, c: Bool, d: [Bool], e: Test) in return "\(a.int), \(b.int), \(c), \(d), \(e.int)" } )
        let a = f()
        let b = "100, 101, true, [false, true], 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr101() {
        // 5, 5, 3, [0, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, "202", test1, test2, 1.2, f: { (a: Test, b: String, c: Test, d: Test, e: Float) in return "\(a.int), \(b), \(c.int), \(d.int), \(e)" } )
        let a = f()
        let b = "100, 202, 101, 102, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr102() {
        // 5, 5, 3, [0, 2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, "202", test1, [false, true], test2, f: { (a: Test, b: String, c: Test, d: [Bool], e: Test) in return "\(a.int), \(b), \(c.int), \(d), \(e.int)" } )
        let a = f()
        let b = "100, 202, 101, [false, true], 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr103() {
        // 5, 5, 3, [0, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(test0, "202", true, test1, test2, f: { (a: Test, b: String, c: Bool, d: Test, e: Test) in return "\(a.int), \(b), \(c), \(d.int), \(e.int)" } )
        let a = f()
        let b = "100, 202, true, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr104() {
        // 5, 5, 3, [1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(201, test0, test1, test2, 1.2, f: { (a: Int, b: Test, c: Test, d: Test, e: Float) in return "\(a), \(b.int), \(c.int), \(d.int), \(e)" } )
        let a = f()
        let b = "201, 100, 101, 102, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr105() {
        // 5, 5, 3, [1, 2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(201, test0, test1, [false, true], test2, f: { (a: Int, b: Test, c: Test, d: [Bool], e: Test) in return "\(a), \(b.int), \(c.int), \(d), \(e.int)" } )
        let a = f()
        let b = "201, 100, 101, [false, true], 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr106() {
        // 5, 5, 3, [1, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(201, test0, true, test1, test2, f: { (a: Int, b: Test, c: Bool, d: Test, e: Test) in return "\(a), \(b.int), \(c), \(d.int), \(e.int)" } )
        let a = f()
        let b = "201, 100, true, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr107() {
        // 5, 5, 3, [2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papplyr(201, "202", test0, test1, test2, f: { (a: Int, b: String, c: Test, d: Test, e: Test) in return "\(a), \(b), \(c.int), \(d.int), \(e.int)" } )
        let a = f()
        let b = "201, 202, 100, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr108() {
        // 5, 5, 4, [0, 1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papplyr(test0, test1, test2, test3, 1.2, f: { (a: Test, b: Test, c: Test, d: Test, e: Float) in return "\(a.int), \(b.int), \(c.int), \(d.int), \(e)" } )
        let a = f()
        let b = "100, 101, 102, 103, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr109() {
        // 5, 5, 4, [0, 1, 2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papplyr(test0, test1, test2, [false, true], test3, f: { (a: Test, b: Test, c: Test, d: [Bool], e: Test) in return "\(a.int), \(b.int), \(c.int), \(d), \(e.int)" } )
        let a = f()
        let b = "100, 101, 102, [false, true], 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr110() {
        // 5, 5, 4, [0, 1, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papplyr(test0, test1, true, test2, test3, f: { (a: Test, b: Test, c: Bool, d: Test, e: Test) in return "\(a.int), \(b.int), \(c), \(d.int), \(e.int)" } )
        let a = f()
        let b = "100, 101, true, 102, 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr111() {
        // 5, 5, 4, [0, 2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papplyr(test0, "202", test1, test2, test3, f: { (a: Test, b: String, c: Test, d: Test, e: Test) in return "\(a.int), \(b), \(c.int), \(d.int), \(e.int)" } )
        let a = f()
        let b = "100, 202, 101, 102, 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr112() {
        // 5, 5, 4, [1, 2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papplyr(201, test0, test1, test2, test3, f: { (a: Int, b: Test, c: Test, d: Test, e: Test) in return "\(a), \(b.int), \(c.int), \(d.int), \(e.int)" } )
        let a = f()
        let b = "201, 100, 101, 102, 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapplyr113() {
        // 5, 5, 5, [0, 1, 2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let test4 = Test(int: 104)
        let f = papplyr(test0, test1, test2, test3, test4, f: { (a: Test, b: Test, c: Test, d: Test, e: Test) in return "\(a.int), \(b.int), \(c.int), \(d.int), \(e.int)" } )
        let a = f()
        let b = "100, 101, 102, 103, 104"
        XCTAssertEqual(a, b)
    }
    
}

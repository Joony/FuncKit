//
//  PapplyTests2.swift
//  FunKitTests
//
//  Created by Jonathan McAllister on 15/01/2018.
//  Copyright © 2018 FunKit. All rights reserved.
//

import XCTest
@testable import FunKit

class Test {
    let int: Int
    init(int: Int) {
        self.int = int
    }
}

class PapplyTests: XCTestCase {
    
    func testPapply0() {
        // 1, 1, 0, []
        let f = papply(201, f: { (a: Int) in return "\(a)" } )
        let a = f()
        let b = "201"
        XCTAssertEqual(a, b)
    }
    
    func testPapply1() {
        // 1, 1, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, f: { (a: Test) in return "\(a.int)" } )
        let a = f()
        let b = "100"
        XCTAssertEqual(a, b)
    }
    
    func testPapply2() {
        // 2, 1, 0, []
        let f = papply(201, f: { (a: Int, b: String) in return "\(a), \(b)" } )
        let a = f("202")
        let b = "201, 202"
        XCTAssertEqual(a, b)
    }
    
    func testPapply3() {
        // 2, 1, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, f: { (a: Test, b: String) in return "\(a.int), \(b)" } )
        let a = f("202")
        let b = "100, 202"
        XCTAssertEqual(a, b)
    }
    
    func testPapply4() {
        // 2, 2, 0, []
        let f = papply(201, "202", f: { (a: Int, b: String) in return "\(a), \(b)" } )
        let a = f()
        let b = "201, 202"
        XCTAssertEqual(a, b)
    }
    
    func testPapply5() {
        // 2, 2, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, "202", f: { (a: Test, b: String) in return "\(a.int), \(b)" } )
        let a = f()
        let b = "100, 202"
        XCTAssertEqual(a, b)
    }
    
    func testPapply6() {
        // 2, 2, 1, [1]
        let test0 = Test(int: 100)
        let f = papply(201, test0, f: { (a: Int, b: Test) in return "\(a), \(b.int)" } )
        let a = f()
        let b = "201, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapply7() {
        // 2, 2, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, test1, f: { (a: Test, b: Test) in return "\(a.int), \(b.int)" } )
        let a = f()
        let b = "100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapply8() {
        // 3, 1, 0, []
        let f = papply(201, f: { (a: Int, b: String, c: Bool) in return "\(a), \(b), \(c)" } )
        let a = f("202", true)
        let b = "201, 202, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapply9() {
        // 3, 1, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, f: { (a: Test, b: String, c: Bool) in return "\(a.int), \(b), \(c)" } )
        let a = f("202", true)
        let b = "100, 202, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapply10() {
        // 3, 2, 0, []
        let f = papply(201, "202", f: { (a: Int, b: String, c: Bool) in return "\(a), \(b), \(c)" } )
        let a = f(true)
        let b = "201, 202, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapply11() {
        // 3, 2, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, "202", f: { (a: Test, b: String, c: Bool) in return "\(a.int), \(b), \(c)" } )
        let a = f(true)
        let b = "100, 202, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapply12() {
        // 3, 2, 1, [1]
        let test0 = Test(int: 100)
        let f = papply(201, test0, f: { (a: Int, b: Test, c: Bool) in return "\(a), \(b.int), \(c)" } )
        let a = f(true)
        let b = "201, 100, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapply13() {
        // 3, 2, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, test1, f: { (a: Test, b: Test, c: Bool) in return "\(a.int), \(b.int), \(c)" } )
        let a = f(true)
        let b = "100, 101, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapply14() {
        // 3, 3, 0, []
        let f = papply(201, "202", true, f: { (a: Int, b: String, c: Bool) in return "\(a), \(b), \(c)" } )
        let a = f()
        let b = "201, 202, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapply15() {
        // 3, 3, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, "202", true, f: { (a: Test, b: String, c: Bool) in return "\(a.int), \(b), \(c)" } )
        let a = f()
        let b = "100, 202, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapply16() {
        // 3, 3, 1, [1]
        let test0 = Test(int: 100)
        let f = papply(201, test0, true, f: { (a: Int, b: Test, c: Bool) in return "\(a), \(b.int), \(c)" } )
        let a = f()
        let b = "201, 100, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapply17() {
        // 3, 3, 1, [2]
        let test0 = Test(int: 100)
        let f = papply(201, "202", test0, f: { (a: Int, b: String, c: Test) in return "\(a), \(b), \(c.int)" } )
        let a = f()
        let b = "201, 202, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapply18() {
        // 3, 3, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, test1, true, f: { (a: Test, b: Test, c: Bool) in return "\(a.int), \(b.int), \(c)" } )
        let a = f()
        let b = "100, 101, true"
        XCTAssertEqual(a, b)
    }
    
    func testPapply19() {
        // 3, 3, 2, [0, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, "202", test1, f: { (a: Test, b: String, c: Test) in return "\(a.int), \(b), \(c.int)" } )
        let a = f()
        let b = "100, 202, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapply20() {
        // 3, 3, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, test0, test1, f: { (a: Int, b: Test, c: Test) in return "\(a), \(b.int), \(c.int)" } )
        let a = f()
        let b = "201, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapply21() {
        // 3, 3, 3, [0, 1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, test1, test2, f: { (a: Test, b: Test, c: Test) in return "\(a.int), \(b.int), \(c.int)" } )
        let a = f()
        let b = "100, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapply22() {
        // 4, 1, 0, []
        let f = papply(201, f: { (a: Int, b: String, c: Bool, d: [Bool]) in return "\(a), \(b), \(c), \(d)" } )
        let a = f("202", true, [false, true])
        let b = "201, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply23() {
        // 4, 1, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, f: { (a: Test, b: String, c: Bool, d: [Bool]) in return "\(a.int), \(b), \(c), \(d)" } )
        let a = f("202", true, [false, true])
        let b = "100, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply24() {
        // 4, 2, 0, []
        let f = papply(201, "202", f: { (a: Int, b: String, c: Bool, d: [Bool]) in return "\(a), \(b), \(c), \(d)" } )
        let a = f(true, [false, true])
        let b = "201, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply25() {
        // 4, 2, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, "202", f: { (a: Test, b: String, c: Bool, d: [Bool]) in return "\(a.int), \(b), \(c), \(d)" } )
        let a = f(true, [false, true])
        let b = "100, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply26() {
        // 4, 2, 1, [1]
        let test0 = Test(int: 100)
        let f = papply(201, test0, f: { (a: Int, b: Test, c: Bool, d: [Bool]) in return "\(a), \(b.int), \(c), \(d)" } )
        let a = f(true, [false, true])
        let b = "201, 100, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply27() {
        // 4, 2, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, test1, f: { (a: Test, b: Test, c: Bool, d: [Bool]) in return "\(a.int), \(b.int), \(c), \(d)" } )
        let a = f(true, [false, true])
        let b = "100, 101, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply28() {
        // 4, 3, 0, []
        let f = papply(201, "202", true, f: { (a: Int, b: String, c: Bool, d: [Bool]) in return "\(a), \(b), \(c), \(d)" } )
        let a = f([false, true])
        let b = "201, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply29() {
        // 4, 3, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, "202", true, f: { (a: Test, b: String, c: Bool, d: [Bool]) in return "\(a.int), \(b), \(c), \(d)" } )
        let a = f([false, true])
        let b = "100, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply30() {
        // 4, 3, 1, [1]
        let test0 = Test(int: 100)
        let f = papply(201, test0, true, f: { (a: Int, b: Test, c: Bool, d: [Bool]) in return "\(a), \(b.int), \(c), \(d)" } )
        let a = f([false, true])
        let b = "201, 100, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply31() {
        // 4, 3, 1, [2]
        let test0 = Test(int: 100)
        let f = papply(201, "202", test0, f: { (a: Int, b: String, c: Test, d: [Bool]) in return "\(a), \(b), \(c.int), \(d)" } )
        let a = f([false, true])
        let b = "201, 202, 100, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply32() {
        // 4, 3, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, test1, true, f: { (a: Test, b: Test, c: Bool, d: [Bool]) in return "\(a.int), \(b.int), \(c), \(d)" } )
        let a = f([false, true])
        let b = "100, 101, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply33() {
        // 4, 3, 2, [0, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, "202", test1, f: { (a: Test, b: String, c: Test, d: [Bool]) in return "\(a.int), \(b), \(c.int), \(d)" } )
        let a = f([false, true])
        let b = "100, 202, 101, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply34() {
        // 4, 3, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, test0, test1, f: { (a: Int, b: Test, c: Test, d: [Bool]) in return "\(a), \(b.int), \(c.int), \(d)" } )
        let a = f([false, true])
        let b = "201, 100, 101, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply35() {
        // 4, 3, 3, [0, 1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, test1, test2, f: { (a: Test, b: Test, c: Test, d: [Bool]) in return "\(a.int), \(b.int), \(c.int), \(d)" } )
        let a = f([false, true])
        let b = "100, 101, 102, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply36() {
        // 4, 4, 0, []
        let f = papply(201, "202", true, [false, true], f: { (a: Int, b: String, c: Bool, d: [Bool]) in return "\(a), \(b), \(c), \(d)" } )
        let a = f()
        let b = "201, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply37() {
        // 4, 4, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, "202", true, [false, true], f: { (a: Test, b: String, c: Bool, d: [Bool]) in return "\(a.int), \(b), \(c), \(d)" } )
        let a = f()
        let b = "100, 202, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply38() {
        // 4, 4, 1, [1]
        let test0 = Test(int: 100)
        let f = papply(201, test0, true, [false, true], f: { (a: Int, b: Test, c: Bool, d: [Bool]) in return "\(a), \(b.int), \(c), \(d)" } )
        let a = f()
        let b = "201, 100, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply39() {
        // 4, 4, 1, [2]
        let test0 = Test(int: 100)
        let f = papply(201, "202", test0, [false, true], f: { (a: Int, b: String, c: Test, d: [Bool]) in return "\(a), \(b), \(c.int), \(d)" } )
        let a = f()
        let b = "201, 202, 100, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply40() {
        // 4, 4, 1, [3]
        let test0 = Test(int: 100)
        let f = papply(201, "202", true, test0, f: { (a: Int, b: String, c: Bool, d: Test) in return "\(a), \(b), \(c), \(d.int)" } )
        let a = f()
        let b = "201, 202, true, 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapply41() {
        // 4, 4, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, test1, true, [false, true], f: { (a: Test, b: Test, c: Bool, d: [Bool]) in return "\(a.int), \(b.int), \(c), \(d)" } )
        let a = f()
        let b = "100, 101, true, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply42() {
        // 4, 4, 2, [0, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, "202", test1, [false, true], f: { (a: Test, b: String, c: Test, d: [Bool]) in return "\(a.int), \(b), \(c.int), \(d)" } )
        let a = f()
        let b = "100, 202, 101, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply43() {
        // 4, 4, 2, [0, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, "202", true, test1, f: { (a: Test, b: String, c: Bool, d: Test) in return "\(a.int), \(b), \(c), \(d.int)" } )
        let a = f()
        let b = "100, 202, true, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapply44() {
        // 4, 4, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, test0, test1, [false, true], f: { (a: Int, b: Test, c: Test, d: [Bool]) in return "\(a), \(b.int), \(c.int), \(d)" } )
        let a = f()
        let b = "201, 100, 101, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply45() {
        // 4, 4, 2, [1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, test0, true, test1, f: { (a: Int, b: Test, c: Bool, d: Test) in return "\(a), \(b.int), \(c), \(d.int)" } )
        let a = f()
        let b = "201, 100, true, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapply46() {
        // 4, 4, 2, [2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, "202", test0, test1, f: { (a: Int, b: String, c: Test, d: Test) in return "\(a), \(b), \(c.int), \(d.int)" } )
        let a = f()
        let b = "201, 202, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapply47() {
        // 4, 4, 3, [0, 1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, test1, test2, [false, true], f: { (a: Test, b: Test, c: Test, d: [Bool]) in return "\(a.int), \(b.int), \(c.int), \(d)" } )
        let a = f()
        let b = "100, 101, 102, [false, true]"
        XCTAssertEqual(a, b)
    }
    
    func testPapply48() {
        // 4, 4, 3, [0, 1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, test1, true, test2, f: { (a: Test, b: Test, c: Bool, d: Test) in return "\(a.int), \(b.int), \(c), \(d.int)" } )
        let a = f()
        let b = "100, 101, true, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapply49() {
        // 4, 4, 3, [0, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, "202", test1, test2, f: { (a: Test, b: String, c: Test, d: Test) in return "\(a.int), \(b), \(c.int), \(d.int)" } )
        let a = f()
        let b = "100, 202, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapply50() {
        // 4, 4, 3, [1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(201, test0, test1, test2, f: { (a: Int, b: Test, c: Test, d: Test) in return "\(a), \(b.int), \(c.int), \(d.int)" } )
        let a = f()
        let b = "201, 100, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapply51() {
        // 4, 4, 4, [0, 1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papply(test0, test1, test2, test3, f: { (a: Test, b: Test, c: Test, d: Test) in return "\(a.int), \(b.int), \(c.int), \(d.int)" } )
        let a = f()
        let b = "100, 101, 102, 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapply52() {
        // 5, 1, 0, []
        let f = papply(201, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Float) in return "\(a), \(b), \(c), \(d), \(e)" } )
        let a = f("202", true, [false, true], 1.2)
        let b = "201, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply53() {
        // 5, 1, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, f: { (a: Test, b: String, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b), \(c), \(d), \(e)" } )
        let a = f("202", true, [false, true], 1.2)
        let b = "100, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply54() {
        // 5, 2, 0, []
        let f = papply(201, "202", f: { (a: Int, b: String, c: Bool, d: [Bool], e: Float) in return "\(a), \(b), \(c), \(d), \(e)" } )
        let a = f(true, [false, true], 1.2)
        let b = "201, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply55() {
        // 5, 2, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, "202", f: { (a: Test, b: String, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b), \(c), \(d), \(e)" } )
        let a = f(true, [false, true], 1.2)
        let b = "100, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply56() {
        // 5, 2, 1, [1]
        let test0 = Test(int: 100)
        let f = papply(201, test0, f: { (a: Int, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a), \(b.int), \(c), \(d), \(e)" } )
        let a = f(true, [false, true], 1.2)
        let b = "201, 100, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply57() {
        // 5, 2, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, test1, f: { (a: Test, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b.int), \(c), \(d), \(e)" } )
        let a = f(true, [false, true], 1.2)
        let b = "100, 101, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply58() {
        // 5, 3, 0, []
        let f = papply(201, "202", true, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Float) in return "\(a), \(b), \(c), \(d), \(e)" } )
        let a = f([false, true], 1.2)
        let b = "201, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply59() {
        // 5, 3, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, "202", true, f: { (a: Test, b: String, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b), \(c), \(d), \(e)" } )
        let a = f([false, true], 1.2)
        let b = "100, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply60() {
        // 5, 3, 1, [1]
        let test0 = Test(int: 100)
        let f = papply(201, test0, true, f: { (a: Int, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a), \(b.int), \(c), \(d), \(e)" } )
        let a = f([false, true], 1.2)
        let b = "201, 100, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply61() {
        // 5, 3, 1, [2]
        let test0 = Test(int: 100)
        let f = papply(201, "202", test0, f: { (a: Int, b: String, c: Test, d: [Bool], e: Float) in return "\(a), \(b), \(c.int), \(d), \(e)" } )
        let a = f([false, true], 1.2)
        let b = "201, 202, 100, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply62() {
        // 5, 3, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, test1, true, f: { (a: Test, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b.int), \(c), \(d), \(e)" } )
        let a = f([false, true], 1.2)
        let b = "100, 101, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply63() {
        // 5, 3, 2, [0, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, "202", test1, f: { (a: Test, b: String, c: Test, d: [Bool], e: Float) in return "\(a.int), \(b), \(c.int), \(d), \(e)" } )
        let a = f([false, true], 1.2)
        let b = "100, 202, 101, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply64() {
        // 5, 3, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, test0, test1, f: { (a: Int, b: Test, c: Test, d: [Bool], e: Float) in return "\(a), \(b.int), \(c.int), \(d), \(e)" } )
        let a = f([false, true], 1.2)
        let b = "201, 100, 101, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply65() {
        // 5, 3, 3, [0, 1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, test1, test2, f: { (a: Test, b: Test, c: Test, d: [Bool], e: Float) in return "\(a.int), \(b.int), \(c.int), \(d), \(e)" } )
        let a = f([false, true], 1.2)
        let b = "100, 101, 102, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply66() {
        // 5, 4, 0, []
        let f = papply(201, "202", true, [false, true], f: { (a: Int, b: String, c: Bool, d: [Bool], e: Float) in return "\(a), \(b), \(c), \(d), \(e)" } )
        let a = f(1.2)
        let b = "201, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply67() {
        // 5, 4, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, "202", true, [false, true], f: { (a: Test, b: String, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b), \(c), \(d), \(e)" } )
        let a = f(1.2)
        let b = "100, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply68() {
        // 5, 4, 1, [1]
        let test0 = Test(int: 100)
        let f = papply(201, test0, true, [false, true], f: { (a: Int, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a), \(b.int), \(c), \(d), \(e)" } )
        let a = f(1.2)
        let b = "201, 100, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply69() {
        // 5, 4, 1, [2]
        let test0 = Test(int: 100)
        let f = papply(201, "202", test0, [false, true], f: { (a: Int, b: String, c: Test, d: [Bool], e: Float) in return "\(a), \(b), \(c.int), \(d), \(e)" } )
        let a = f(1.2)
        let b = "201, 202, 100, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply70() {
        // 5, 4, 1, [3]
        let test0 = Test(int: 100)
        let f = papply(201, "202", true, test0, f: { (a: Int, b: String, c: Bool, d: Test, e: Float) in return "\(a), \(b), \(c), \(d.int), \(e)" } )
        let a = f(1.2)
        let b = "201, 202, true, 100, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply71() {
        // 5, 4, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, test1, true, [false, true], f: { (a: Test, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b.int), \(c), \(d), \(e)" } )
        let a = f(1.2)
        let b = "100, 101, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply72() {
        // 5, 4, 2, [0, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, "202", test1, [false, true], f: { (a: Test, b: String, c: Test, d: [Bool], e: Float) in return "\(a.int), \(b), \(c.int), \(d), \(e)" } )
        let a = f(1.2)
        let b = "100, 202, 101, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply73() {
        // 5, 4, 2, [0, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, "202", true, test1, f: { (a: Test, b: String, c: Bool, d: Test, e: Float) in return "\(a.int), \(b), \(c), \(d.int), \(e)" } )
        let a = f(1.2)
        let b = "100, 202, true, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply74() {
        // 5, 4, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, test0, test1, [false, true], f: { (a: Int, b: Test, c: Test, d: [Bool], e: Float) in return "\(a), \(b.int), \(c.int), \(d), \(e)" } )
        let a = f(1.2)
        let b = "201, 100, 101, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply75() {
        // 5, 4, 2, [1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, test0, true, test1, f: { (a: Int, b: Test, c: Bool, d: Test, e: Float) in return "\(a), \(b.int), \(c), \(d.int), \(e)" } )
        let a = f(1.2)
        let b = "201, 100, true, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply76() {
        // 5, 4, 2, [2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, "202", test0, test1, f: { (a: Int, b: String, c: Test, d: Test, e: Float) in return "\(a), \(b), \(c.int), \(d.int), \(e)" } )
        let a = f(1.2)
        let b = "201, 202, 100, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply77() {
        // 5, 4, 3, [0, 1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, test1, test2, [false, true], f: { (a: Test, b: Test, c: Test, d: [Bool], e: Float) in return "\(a.int), \(b.int), \(c.int), \(d), \(e)" } )
        let a = f(1.2)
        let b = "100, 101, 102, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply78() {
        // 5, 4, 3, [0, 1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, test1, true, test2, f: { (a: Test, b: Test, c: Bool, d: Test, e: Float) in return "\(a.int), \(b.int), \(c), \(d.int), \(e)" } )
        let a = f(1.2)
        let b = "100, 101, true, 102, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply79() {
        // 5, 4, 3, [0, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, "202", test1, test2, f: { (a: Test, b: String, c: Test, d: Test, e: Float) in return "\(a.int), \(b), \(c.int), \(d.int), \(e)" } )
        let a = f(1.2)
        let b = "100, 202, 101, 102, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply80() {
        // 5, 4, 3, [1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(201, test0, test1, test2, f: { (a: Int, b: Test, c: Test, d: Test, e: Float) in return "\(a), \(b.int), \(c.int), \(d.int), \(e)" } )
        let a = f(1.2)
        let b = "201, 100, 101, 102, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply81() {
        // 5, 4, 4, [0, 1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papply(test0, test1, test2, test3, f: { (a: Test, b: Test, c: Test, d: Test, e: Float) in return "\(a.int), \(b.int), \(c.int), \(d.int), \(e)" } )
        let a = f(1.2)
        let b = "100, 101, 102, 103, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply82() {
        // 5, 5, 0, []
        let f = papply(201, "202", true, [false, true], 1.2, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Float) in return "\(a), \(b), \(c), \(d), \(e)" } )
        let a = f()
        let b = "201, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply83() {
        // 5, 5, 1, [0]
        let test0 = Test(int: 100)
        let f = papply(test0, "202", true, [false, true], 1.2, f: { (a: Test, b: String, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b), \(c), \(d), \(e)" } )
        let a = f()
        let b = "100, 202, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply84() {
        // 5, 5, 1, [1]
        let test0 = Test(int: 100)
        let f = papply(201, test0, true, [false, true], 1.2, f: { (a: Int, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a), \(b.int), \(c), \(d), \(e)" } )
        let a = f()
        let b = "201, 100, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply85() {
        // 5, 5, 1, [2]
        let test0 = Test(int: 100)
        let f = papply(201, "202", test0, [false, true], 1.2, f: { (a: Int, b: String, c: Test, d: [Bool], e: Float) in return "\(a), \(b), \(c.int), \(d), \(e)" } )
        let a = f()
        let b = "201, 202, 100, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply86() {
        // 5, 5, 1, [3]
        let test0 = Test(int: 100)
        let f = papply(201, "202", true, test0, 1.2, f: { (a: Int, b: String, c: Bool, d: Test, e: Float) in return "\(a), \(b), \(c), \(d.int), \(e)" } )
        let a = f()
        let b = "201, 202, true, 100, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply87() {
        // 5, 5, 1, [4]
        let test0 = Test(int: 100)
        let f = papply(201, "202", true, [false, true], test0, f: { (a: Int, b: String, c: Bool, d: [Bool], e: Test) in return "\(a), \(b), \(c), \(d), \(e.int)" } )
        let a = f()
        let b = "201, 202, true, [false, true], 100"
        XCTAssertEqual(a, b)
    }
    
    func testPapply88() {
        // 5, 5, 2, [0, 1]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, test1, true, [false, true], 1.2, f: { (a: Test, b: Test, c: Bool, d: [Bool], e: Float) in return "\(a.int), \(b.int), \(c), \(d), \(e)" } )
        let a = f()
        let b = "100, 101, true, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply89() {
        // 5, 5, 2, [0, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, "202", test1, [false, true], 1.2, f: { (a: Test, b: String, c: Test, d: [Bool], e: Float) in return "\(a.int), \(b), \(c.int), \(d), \(e)" } )
        let a = f()
        let b = "100, 202, 101, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply90() {
        // 5, 5, 2, [0, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, "202", true, test1, 1.2, f: { (a: Test, b: String, c: Bool, d: Test, e: Float) in return "\(a.int), \(b), \(c), \(d.int), \(e)" } )
        let a = f()
        let b = "100, 202, true, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply91() {
        // 5, 5, 2, [0, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(test0, "202", true, [false, true], test1, f: { (a: Test, b: String, c: Bool, d: [Bool], e: Test) in return "\(a.int), \(b), \(c), \(d), \(e.int)" } )
        let a = f()
        let b = "100, 202, true, [false, true], 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapply92() {
        // 5, 5, 2, [1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, test0, test1, [false, true], 1.2, f: { (a: Int, b: Test, c: Test, d: [Bool], e: Float) in return "\(a), \(b.int), \(c.int), \(d), \(e)" } )
        let a = f()
        let b = "201, 100, 101, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply93() {
        // 5, 5, 2, [1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, test0, true, test1, 1.2, f: { (a: Int, b: Test, c: Bool, d: Test, e: Float) in return "\(a), \(b.int), \(c), \(d.int), \(e)" } )
        let a = f()
        let b = "201, 100, true, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply94() {
        // 5, 5, 2, [1, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, test0, true, [false, true], test1, f: { (a: Int, b: Test, c: Bool, d: [Bool], e: Test) in return "\(a), \(b.int), \(c), \(d), \(e.int)" } )
        let a = f()
        let b = "201, 100, true, [false, true], 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapply95() {
        // 5, 5, 2, [2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, "202", test0, test1, 1.2, f: { (a: Int, b: String, c: Test, d: Test, e: Float) in return "\(a), \(b), \(c.int), \(d.int), \(e)" } )
        let a = f()
        let b = "201, 202, 100, 101, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply96() {
        // 5, 5, 2, [2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, "202", test0, [false, true], test1, f: { (a: Int, b: String, c: Test, d: [Bool], e: Test) in return "\(a), \(b), \(c.int), \(d), \(e.int)" } )
        let a = f()
        let b = "201, 202, 100, [false, true], 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapply97() {
        // 5, 5, 2, [3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let f = papply(201, "202", true, test0, test1, f: { (a: Int, b: String, c: Bool, d: Test, e: Test) in return "\(a), \(b), \(c), \(d.int), \(e.int)" } )
        let a = f()
        let b = "201, 202, true, 100, 101"
        XCTAssertEqual(a, b)
    }
    
    func testPapply98() {
        // 5, 5, 3, [0, 1, 2]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, test1, test2, [false, true], 1.2, f: { (a: Test, b: Test, c: Test, d: [Bool], e: Float) in return "\(a.int), \(b.int), \(c.int), \(d), \(e)" } )
        let a = f()
        let b = "100, 101, 102, [false, true], 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply99() {
        // 5, 5, 3, [0, 1, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, test1, true, test2, 1.2, f: { (a: Test, b: Test, c: Bool, d: Test, e: Float) in return "\(a.int), \(b.int), \(c), \(d.int), \(e)" } )
        let a = f()
        let b = "100, 101, true, 102, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply100() {
        // 5, 5, 3, [0, 1, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, test1, true, [false, true], test2, f: { (a: Test, b: Test, c: Bool, d: [Bool], e: Test) in return "\(a.int), \(b.int), \(c), \(d), \(e.int)" } )
        let a = f()
        let b = "100, 101, true, [false, true], 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapply101() {
        // 5, 5, 3, [0, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, "202", test1, test2, 1.2, f: { (a: Test, b: String, c: Test, d: Test, e: Float) in return "\(a.int), \(b), \(c.int), \(d.int), \(e)" } )
        let a = f()
        let b = "100, 202, 101, 102, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply102() {
        // 5, 5, 3, [0, 2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, "202", test1, [false, true], test2, f: { (a: Test, b: String, c: Test, d: [Bool], e: Test) in return "\(a.int), \(b), \(c.int), \(d), \(e.int)" } )
        let a = f()
        let b = "100, 202, 101, [false, true], 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapply103() {
        // 5, 5, 3, [0, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(test0, "202", true, test1, test2, f: { (a: Test, b: String, c: Bool, d: Test, e: Test) in return "\(a.int), \(b), \(c), \(d.int), \(e.int)" } )
        let a = f()
        let b = "100, 202, true, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapply104() {
        // 5, 5, 3, [1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(201, test0, test1, test2, 1.2, f: { (a: Int, b: Test, c: Test, d: Test, e: Float) in return "\(a), \(b.int), \(c.int), \(d.int), \(e)" } )
        let a = f()
        let b = "201, 100, 101, 102, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply105() {
        // 5, 5, 3, [1, 2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(201, test0, test1, [false, true], test2, f: { (a: Int, b: Test, c: Test, d: [Bool], e: Test) in return "\(a), \(b.int), \(c.int), \(d), \(e.int)" } )
        let a = f()
        let b = "201, 100, 101, [false, true], 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapply106() {
        // 5, 5, 3, [1, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(201, test0, true, test1, test2, f: { (a: Int, b: Test, c: Bool, d: Test, e: Test) in return "\(a), \(b.int), \(c), \(d.int), \(e.int)" } )
        let a = f()
        let b = "201, 100, true, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapply107() {
        // 5, 5, 3, [2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let f = papply(201, "202", test0, test1, test2, f: { (a: Int, b: String, c: Test, d: Test, e: Test) in return "\(a), \(b), \(c.int), \(d.int), \(e.int)" } )
        let a = f()
        let b = "201, 202, 100, 101, 102"
        XCTAssertEqual(a, b)
    }
    
    func testPapply108() {
        // 5, 5, 4, [0, 1, 2, 3]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papply(test0, test1, test2, test3, 1.2, f: { (a: Test, b: Test, c: Test, d: Test, e: Float) in return "\(a.int), \(b.int), \(c.int), \(d.int), \(e)" } )
        let a = f()
        let b = "100, 101, 102, 103, 1.2"
        XCTAssertEqual(a, b)
    }
    
    func testPapply109() {
        // 5, 5, 4, [0, 1, 2, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papply(test0, test1, test2, [false, true], test3, f: { (a: Test, b: Test, c: Test, d: [Bool], e: Test) in return "\(a.int), \(b.int), \(c.int), \(d), \(e.int)" } )
        let a = f()
        let b = "100, 101, 102, [false, true], 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapply110() {
        // 5, 5, 4, [0, 1, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papply(test0, test1, true, test2, test3, f: { (a: Test, b: Test, c: Bool, d: Test, e: Test) in return "\(a.int), \(b.int), \(c), \(d.int), \(e.int)" } )
        let a = f()
        let b = "100, 101, true, 102, 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapply111() {
        // 5, 5, 4, [0, 2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papply(test0, "202", test1, test2, test3, f: { (a: Test, b: String, c: Test, d: Test, e: Test) in return "\(a.int), \(b), \(c.int), \(d.int), \(e.int)" } )
        let a = f()
        let b = "100, 202, 101, 102, 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapply112() {
        // 5, 5, 4, [1, 2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let f = papply(201, test0, test1, test2, test3, f: { (a: Int, b: Test, c: Test, d: Test, e: Test) in return "\(a), \(b.int), \(c.int), \(d.int), \(e.int)" } )
        let a = f()
        let b = "201, 100, 101, 102, 103"
        XCTAssertEqual(a, b)
    }
    
    func testPapply113() {
        // 5, 5, 5, [0, 1, 2, 3, 4]
        let test0 = Test(int: 100)
        let test1 = Test(int: 101)
        let test2 = Test(int: 102)
        let test3 = Test(int: 103)
        let test4 = Test(int: 104)
        let f = papply(test0, test1, test2, test3, test4, f: { (a: Test, b: Test, c: Test, d: Test, e: Test) in return "\(a.int), \(b.int), \(c.int), \(d.int), \(e.int)" } )
        let a = f()
        let b = "100, 101, 102, 103, 104"
        XCTAssertEqual(a, b)
    }
    
}

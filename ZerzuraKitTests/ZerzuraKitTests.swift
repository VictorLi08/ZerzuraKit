//
//  ZerzuraKitTests.swift
//  ZerzuraKitTests
//
//  Created by Victor Li on 2019/8/19.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import XCTest
@testable import ZerzuraKit

class ZerzuraKitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIncrement() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var a = 0
        let b = (a++)
        a++
        XCTAssert(b == 0)
        XCTAssert(a == 2)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
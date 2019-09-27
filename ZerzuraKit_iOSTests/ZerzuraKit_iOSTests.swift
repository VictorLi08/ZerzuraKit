//
//  ZerzuraKit_iOSTests.swift
//  ZerzuraKit_iOSTests
//
//  Created by Victor Li on 2019/9/26.
//  Copyright © 2019 Mesarthim. All rights reserved.
//

import XCTest
@testable import ZerzuraKit_iOS

class ZerzuraKit_iOSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class ZLocationTests: XCTestCase {
    override func setUp() {
        
    }
    
    override func tearDown() {
        
    }
    
    func testStore() {
        let myLocation = ZLocation()
        var err: String?
        myLocation.store({ error in
            err = error
        })
        XCTAssert(err == nil)
    }
    
    func testLoad() {
        var myCity = "ASDF"
        let myLocation = ZLocation()
        var err: String?
        
        myLocation.load(completion: { error in
            if error == nil {
                myCity = myLocation.city
            }
            err = error
            
        })
        
        XCTAssert(err == nil)
        XCTAssert(myCity == "ASDF")
    }
}

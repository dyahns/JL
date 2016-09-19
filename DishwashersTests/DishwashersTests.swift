//
//  DishwashersTests.swift
//  DishwashersTests
//
//  Created by Mu-Sonic on 16/09/2016.
//  Copyright © 2016 Mu-Sonic. All rights reserved.
//

import XCTest
@testable import Dishwashers

class DishwashersTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDishwasherThrowsOnInvalidJson() {
        XCTAssertThrowsError(try Dishwasher(json: [ "title": 2 ])) // invalid title
        XCTAssertThrowsError(try Dishwasher(json: [ "name": "Title 2" ])) // missing title
    }
    
    func testDishwashersReturnsCollection() {
        let count = 20
        Dishwasher.dishwashers(from: TestDataProvider(count: count)) { (items) in
            XCTAssert(items.count <= count)
        }
    }

    func testInvalidJsonGracefullyDroppedFromDishwashersCollection() {
        let json = [
            [ "title": "Title 1" ],
            [ "title": 2 ], // invalid title
            [ "name": "Title 2" ], // missing title
            [ "title": "Title 3" ]
        ]
        Dishwasher.dishwashers(from: TestDataProvider(json: json)) { (items) in
            XCTAssert(items.count == 2)
        }
    }
    
/*  func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
*/
}

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
        // invalid title
        XCTAssertThrowsError(try Dishwasher(json: [ "title": 2, "price": [ "now": "0.0" ], "image": "" ]))
        
        // missing title
        XCTAssertThrowsError(try Dishwasher(json: [ "price": [ "now": "0.0" ], "image": "" ]))
        
        // invalid price
        XCTAssertThrowsError(try Dishwasher(json: [ "title": "Title 2", "price": [ "now": 0.0 ], "image": ""]))
    }

    func testDishwasherDetailsAreAsExpected() {
        let dishwasher = try! Dishwasher(json: [ "title": "Title 1", "price": [ "now": "101.1" ], "image": "image url"])
        
        XCTAssertEqual(dishwasher.title, "Title 1")
        XCTAssertEqual(dishwasher.priceNow, 101.1)
        dishwasher.loadImage(from: TestDataProvider(count: 0)) { (data) in
            // TestDataProvider implementation doesn't have async code
            XCTAssertEqual(String(data: data, encoding: .utf8)!, "image url")
        }
    }
    
    func testDishwashersReturnsCollection() {
        let count = 20
        Dishwasher.dishwashers(from: TestDataProvider(count: count)) { (items) in
            // TestDataProvider implementation doesn't have async code
            XCTAssert(items.count <= count)
        }
    }

    func testDishwashersGracefullyDropInvalidJsonItems() {
        let json = [
            [ "title": "Title 1", "price": [ "now": "0.0" ], "image": "" ],
            [ "title": 2, "price": [ "now": "0.0" ], "image": "" ], // invalid title
            [ "name": "Title 2", "price": [ "now": "0.0" ], "image": "" ], // missing title
            [ "title": "Title 2", "price": [ "now": 0.0 ], "image": "" ], // invalid price
            [ "title": "Title 3", "price": [ "now": "0.0" ], "image": "" ]
        ]
        Dishwasher.dishwashers(from: TestDataProvider(json: json)) { (items) in
            // TestDataProvider implementation doesn't have async code
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

//
//  JLAPIDataProviderTests.swift
//  Dishwashers
//
//  Created by Mu-Sonic on 19/09/2016.
//  Copyright © 2016 Mu-Sonic. All rights reserved.
//

import XCTest
@testable import Dishwashers

class JLAPIDataProviderTests: XCTestCase {
    var provider: JLAPIDataProvider!
    let sessionDelegate = TestSessionDelegate()
        
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        provider = JLAPIDataProvider(sessionDelegate: sessionDelegate)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCanLoadDishwashersJsonAsync() {
        let exp = expectation(description: "JSON loaded")
        
        self.provider.getJson { (productsJson) in
            XCTAssertEqual(productsJson.count, 20)
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error, "getJson callback was never called: \(error!.localizedDescription)")
        }
    }

    func testCanLoadImageAsync() {
        let exp = expectation(description: "Image loaded")
        
        self.provider.getImage(urlString: "//johnlewis.scene7.com/is/image/JohnLewis/236477524?") { (data) in
            guard let _ = UIImage(data: data) else {
                XCTFail("The response doesn't seem to be an image")
                return
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertNil(error, "getImage callback was never called: \(error!.localizedDescription)")
            
        }
    }
    
    func testSessionReadsFromCache() {
        // invalidate cache
        self.provider.session.reset {
            NSLog("Session reset")
        }
        
        let url = "//johnlewis.scene7.com/is/image/JohnLewis/236477524?"
        
        let exp1 = expectation(description: "Image loaded from server")
        self.provider.getImage(urlString: url) { (data) in
            exp1.fulfill()
        }
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertEqual(self.sessionDelegate.lastFetchType!, URLSessionTaskMetrics.ResourceFetchType.networkLoad)
        }
        
        let exp2 = expectation(description: "Image loaded from cache")
        self.provider.getImage(urlString: url) { (data) in
            exp2.fulfill()
        }
        waitForExpectations(timeout: 5) { (error) in
            XCTAssertEqual(self.sessionDelegate.lastFetchType!, URLSessionTaskMetrics.ResourceFetchType.localCache)
        }

    }
}

//
//  TestDataProvider.swift
//  Dishwashers
//
//  Created by Mu-Sonic on 17/09/2016.
//  Copyright © 2016 Mu-Sonic. All rights reserved.
//

@testable import Dishwashers

class TestDataProvider: DataProviderProtocol {
    private let data: [[String : Any]]
    
    init(count: Int) {
        data = (0..<count).map { ["title": "\($0)"] }
    }

    init(json: [[String : Any]]) {
        data = json
    }

    func getJson(jsonHandler: @escaping ([[String : Any]]) -> Void) {
        jsonHandler(data)
    }
}

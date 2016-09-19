//
//  Dishwasher.swift
//  Dishwashers
//
//  Created by Mu-Sonic on 16/09/2016.
//  Copyright © 2016 Mu-Sonic. All rights reserved.
//

import Foundation

class Dishwasher {
    let title: String
    
    init(json: [String: Any]) throws {
        guard let title = json["title"] as? String else {
            throw SerializationError.missing("title")
        }
        self.title = title
    }
    
    static func dishwashers(from dataProvider: DataProviderProtocol, completion: @escaping ([Dishwasher]) -> Void) {
        var dishwashers = [Dishwasher]()
        
        dataProvider.getJson { (items) in
            for item in items {
                if let dishwasher = try? Dishwasher(json: item) {
                    dishwashers.append(dishwasher)
                }
            }

            completion(dishwashers)
        }
    }

}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

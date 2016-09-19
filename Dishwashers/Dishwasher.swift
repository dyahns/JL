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
    let priceNow: Double
    let imageUrl: String
    
    init(json: [String: Any]) throws {
        // title
        guard let title = json["title"] as? String else {
            NSLog("Missing title")
            throw SerializationError.missing("title")
        }
        self.title = title

        // price
        guard let prices = json["price"] as? [String: Any], let priceNow = prices["now"] as? String else {
            NSLog("Missing price")
            throw SerializationError.missing("price")
        }
        guard let price = Double(priceNow) else {
            NSLog("Invalid price")
            throw SerializationError.invalid("price", priceNow)
        }
        self.priceNow = price

        // image
        guard let image = json["image"] as? String else {
            NSLog("Missing image")
            throw SerializationError.missing("image")
        }
        self.imageUrl = image
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

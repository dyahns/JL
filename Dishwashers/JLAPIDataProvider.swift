//
//  JLAPIDataProvider.swift
//  Dishwashers
//
//  Created by Mu-Sonic on 17/09/2016.
//  Copyright © 2016 Mu-Sonic. All rights reserved.
//

import Foundation

class JLAPIDataProvider: DataProviderProtocol {
    private let urlString = "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20"

    func getJson(jsonHandler: @escaping ([[String : Any]]) -> Void) {
        let url = URL(string: urlString)!
        
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                NSLog("Error reading data from \(url.absoluteString): \(error.localizedDescription)")
                return
            }

            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let productsJson = json?["products"] as? [[String: Any]] {

                NSLog("Got products...")
                jsonHandler(productsJson)
            }
        }).resume()
    }
    
    func getImage(urlString: String, jsonHandler: @escaping (Data) -> Void) {
        guard let url = URL(string: "https:\(urlString)") else {
            NSLog("Invalid URL error: https:\(urlString)")
            return
        }
        
        session.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                NSLog("Error reading data from \(url.absoluteString): \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                NSLog("Got data from \(urlString)...")
                jsonHandler(data)
            }
        }).resume()
    }
    
    // shared session for interacting with the web service
    lazy var session: URLSession = {
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        
        return session
    }()
}

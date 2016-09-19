//
//  DataProvider.swift
//  Dishwashers
//
//  Created by Mu-Sonic on 17/09/2016.
//  Copyright © 2016 Mu-Sonic. All rights reserved.
//

import Foundation

protocol DataProviderProtocol {
    func getJson(jsonHandler: @escaping ([[String: Any]]) -> Void)
    func getImage(urlString: String, jsonHandler: @escaping (Data) -> Void)
}


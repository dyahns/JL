//
//  TestSessionDelegate.swift
//  Dishwashers
//
//  Created by Mu-Sonic on 19/09/2016.
//  Copyright © 2016 Mu-Sonic. All rights reserved.
//

import Foundation

class TestSessionDelegate: NSObject, URLSessionTaskDelegate {
    var lastUrl: String?
    var lastFetchType: URLSessionTaskMetrics.ResourceFetchType?
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        lastUrl = task.originalRequest?.url?.absoluteString
        lastFetchType = metrics.transactionMetrics[0].resourceFetchType
        
        NSLog("URL \(lastUrl) loaded using \(lastFetchType?.rawValue)")
    }

}

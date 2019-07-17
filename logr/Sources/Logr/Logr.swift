//
//  Logr.swift
//  loggy
//
//  Created by Paulius Gudonis on 28/06/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

class Logr {
    
    private static let queueName = "com.neqsoft.logr"
    private static let localLoggerQueue = DispatchQueue(label: queueName, qos: .background)
    
    init() {}
    
    func debug(_ message: String, _ async: Bool = true) {
        log(.debug, message: message, async)
    }
    
    func info(_ message: String, _ async: Bool = true) {
        log(.info, message: message, async)
    }
    
    func wwarn(_ message: String, _ async: Bool = true) {
        self.log(.warn, message: message, async)
    }
    
    func error(_ message: String, _ async: Bool = true) {
        self.log(.error, message: message, async)
    }
    
    func critical(_ message: String, _ async: Bool = true) {
        self.log(.critical, message: message, async)
    }
    
    private func log(_ level: LogLevel, message: String, _ async: Bool = true) {
       
    }
}

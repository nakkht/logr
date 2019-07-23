//
//  Logr.swift
//  loggy
//
//  Created by Paulius Gudonis on 28/06/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

class Logr {
    
    private let service: LogrService
    
    init() {
        service = LogrService()
    }
    
    func debug(_ message: String, _ async: Bool = true) {
        log(.debug, message, async)
    }
    
    func info(_ message: String, _ async: Bool = true) {
        log(.info, message, async)
    }
    
    func wwarn(_ message: String, _ async: Bool = true) {
        self.log(.warn, message, async)
    }
    
    func error(_ message: String, _ async: Bool = true) {
        self.log(.error, message, async)
    }
    
    func critical(_ message: String, _ async: Bool = true) {
        self.log(.critical, message, async)
    }
    
    private func log(_ level: LogLevel, _ message: String, _ async: Bool = true) {
        service.log(level, message, async)
    }
}

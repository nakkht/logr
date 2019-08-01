//
//  Logr.swift
//  loggy
//
//  Created by Paulius Gudonis on 28/06/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

open class Logr {
    
    private let service: LogrService
    
    public init() {
        service = LogrService()
    }
    
    open func debug(_ message: String, file: String = #file, _ function: String = #function, line: Int = #line, _ async: Bool = true) {
        log(.debug, message, file, function, line, async)
    }
    
    open func info(_ message: String, file: String = #file, _ function: String = #function, line: Int = #line, _ async: Bool = true) {
        log(.info, message, file, function, line, async)
    }
    
    open func warn(_ message: String, file: String = #file, _ function: String = #function, line: Int = #line, _ async: Bool = true) {
        self.log(.warn, message, file, function, line, async)
    }
    
    open func error(_ message: String, file: String = #file, _ function: String = #function, line: Int = #line, _ async: Bool = true) {
        self.log(.error, message, file, function, line, async)
    }
    
    open func critical(_ message: String, file: String = #file, _ function: String = #function, line: Int = #line, _ async: Bool = true) {
        self.log(.critical, message, file, function, line, async)
    }
    
    private func log(_ level: LogLevel, _ message: String, _ file: String = #file, _ function: String = #function, _ line: Int = #line, _ async: Bool = true) {
        service.log(level, message: message, file: file, function: function, line: line, async)
    }
}

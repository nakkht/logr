//
//  Logr.swift
//  loggy
//
//  Created by Paulius Gudonis on 28/06/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

open class Logr {
    
    let service: LogrService
    
    public init(_ service: LogrService? = nil) {
        self.service = service ?? LogrService()
    }
    
    open func debug(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .debug, text: message, meta: MetaInfo(file: file, function: function, line: line)))
    }
    
    open func info(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .info, text: message, meta: MetaInfo(file: file, function: function, line: line)))
    }
    
    open func warn(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .warn, text: message, meta: MetaInfo(file: file, function: function, line: line)))
    }
    
    open func error(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .error, text: message, meta: MetaInfo(file: file, function: function, line: line)))
    }
    
    open func critical(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .critical, text: message, meta: MetaInfo(file: file, function: function, line: line)))
    }
}

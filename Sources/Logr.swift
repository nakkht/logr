//
//  Logr.swift
//  loggy
//
//  Created by Paulius Gudonis on 28/06/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

/// Proxy class used to pass log messages to underlying service.
open class Logr {
    
    /// LogrServiice assigned during initialization. Defaults to main LogrService instance.
    public let service: LogrService
    
    /**
     Initializes new instance of Logr.
     
     - Parameters:
        - serivce: LogrService to which pass logging messages
     */
    public init(_ service: LogrService? = nil) {
        self.service = service ?? LogrService()
    }
    
    /**
     Logs debug type of message to the service.
     
     - Parameters:
        - message: text to be logged
        - file: name of the file where debug function was called
        - function: name of the function where debug function was called
        - line: line number where debug function was called
     */
    open func debug(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .debug, text: message, meta: MetaInfo(file: file, function: function, line: line)))
    }
    
    /**
     Logs info type of message to the service.
     
     - Parameters:
        - message: text to be logged
        - file: name of the file where info function was called
        - function: name of the function where info function was called
        - line: line number where info function was called
     */
    open func info(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .info, text: message, meta: MetaInfo(file: file, function: function, line: line)))
    }
    
    /**
     Logs warn type of message to the service.
     
     - Parameters:
        - message: text to be logged
        - file: name of the file where warn function was called
        - function: name of the function where warn function was called
        - line: line number where warn function was called
     */
    open func warn(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .warn, text: message, meta: MetaInfo(file: file, function: function, line: line)))
    }
    
    /**
     Logs error type of message to the service.
     
     - Parameters:
        - message: text to be logged
        - file: name of the file where error function was called
        - function: name of the function where error function was called
        - line: line number where error function was called
     */
    open func error(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .error, text: message, meta: MetaInfo(file: file, function: function, line: line)))
    }
    
    /**
     Logs critical type of message to the service.
     
     - Parameters:
        - message: text to be logged
        - file: name of the file where critical function was called
        - function: name of the function where critical function was called
        - line: line number where critical function was called
     */
    open func critical(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .critical, text: message, meta: MetaInfo(file: file, function: function, line: line)))
    }
}

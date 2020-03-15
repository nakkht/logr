//
// Copyright 2020 Paulius Gudonis, neqsoft
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// 

import Foundation

/// Proxy class used to pass log messages to underlying service.
open class Logr {
    
    /// LogrServiice instance assigned during initialization. Defaults to main LogrService instance.
    public let service: LogrService
    
    /// Tag assinged during initialization. Used as a prefix for all log messages. Helps to categorize/group messages.
    public let tag: String
    
    /**
     Initializes new instance of Logr.
     
     - Parameters:
        - serivce: LogrService to which pass logging messages
        - tag: Prefix to be used for all messages logged through this Logr instance
     */
    public init(_ tag: String = "", _ service: LogrService? = nil) {
        self.tag = tag
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
        self.service.log(Message(level: .debug,
                                 tag: tag,
                                 text: message,
                                 meta: MetaInfo(file: file, function: function, line: line)))
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
        self.service.log(Message(level: .info,
                                 tag: tag,
                                 text: message,
                                 meta: MetaInfo(file: file, function: function, line: line)))
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
        self.service.log(Message(level: .warn,
                                 tag: tag,
                                 text: message,
                                 meta: MetaInfo(file: file, function: function, line: line)))
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
        self.service.log(Message(level: .error,
                                 tag: tag,
                                 text: message,
                                 meta: MetaInfo(file: file, function: function, line: line)))
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
        self.service.log(Message(level: .critical,
                                 tag: tag,
                                 text: message,
                                 meta: MetaInfo(file: file, function: function, line: line)))
    }
}

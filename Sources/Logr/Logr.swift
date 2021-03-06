//
// Copyright 2020 Paulius Gudonis
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

    /// Initializes new instance of Logr.
    /// - Parameters:
    ///   - tag: prefix to be used for all messages logged through this Logr instance. If not provided, calling file name will be used as a tag.
    ///   - service: LogrService to which pass logging messages.
    public init(_ tag: String = #file, _ service: LogrService? = nil) {
        self.tag = !tag.contains("/") ? tag : tag.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
        self.service = service ?? LogrService()
    }

    /// Logs debug type of message to the service.
    /// - Parameters:
    ///   - message: message to be logged.
    ///   - file: full file path where critical function was called.
    ///   - function: name of the function where critical function was called.
    ///   - line: line number where critical function was called.
    open func debug(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .debug,
                                 tag: tag,
                                 text: message,
                                 meta: MetaInfo(file: file, function: function, line: line, timeStamp: Date())))
    }

    /// Logs info type of message to the service.
    /// - Parameters:
    ///   - message: message to be logged.
    ///   - file: full file path where critical function was called.
    ///   - function: name of the function where critical function was called.
    ///   - line: line number where critical function was called.
    open func info(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .info,
                                 tag: tag,
                                 text: message,
                                 meta: MetaInfo(file: file, function: function, line: line, timeStamp: Date())))
    }

    /// Logs warn type of message to the service.
    /// - Parameters:
    ///   - message: message to be logged.
    ///   - file: full file path where critical function was called.
    ///   - function: name of the function where critical function was called.
    ///   - line: line number where critical function was called.
    open func warn(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .warn,
                                 tag: tag,
                                 text: message,
                                 meta: MetaInfo(file: file, function: function, line: line, timeStamp: Date())))
    }

    /// Logs error type of message to the service.
    /// - Parameters:
    ///   - message: message to be logged.
    ///   - file: full file path where critical function was called.
    ///   - function: name of the function where critical function was called.
    ///   - line: line number where critical function was called.
    open func error(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .error,
                                 tag: tag,
                                 text: message,
                                 meta: MetaInfo(file: file, function: function, line: line, timeStamp: Date())))
    }

    /// Logs critical type of message to the service.
    /// - Parameters:
    ///   - message: message to be logged.
    ///   - file: full file path where critical function was called.
    ///   - function: name of the function where critical function was called.
    ///   - line: line number where critical function was called.
    open func critical(_ message: String, _ file: String = #file, _ function: String = #function, line: Int = #line) {
        self.service.log(Message(level: .critical,
                                 tag: tag,
                                 text: message,
                                 meta: MetaInfo(file: file, function: function, line: line, timeStamp: Date())))
    }
}

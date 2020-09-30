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

/// Immutable struct used to encapsulate consolet target configuration values.
public struct ConsoleTargetConfig {
    
    /// Subsystem name value assigned during initialization. Used for OSLog configuration.
    public let subsystem: String
    
    /// Category name value assigned during initialization. Used for OSLog configuration.
    public let category: String
    
    /// Minimum log levlel to be logged.
    public let level: LogLevel
    
    /// Logging style value assigned during initialization.
    public let style: Style
    
    /// Initialzes configuration struct with provided values.
    /// - Parameters:
    ///   - subsystem: title of OSLog subsystem. Helps to distinguish logs within Console logs. Defaults to: `logr.subsystem`
    ///   - category: title of OSLog category. Helps to distinguish logs within Console logs. Defaults to: `ConsoleTarget`
    ///   - level: lowest log level which shall be logged.
    ///   - style: logging style. Defaults to: `minimal`
    public init(subsystem: String = "logr.subsystem", category: String = "ConsoleTarget",
                level: LogLevel = .debug, style: Style = .minimal) {
        self.subsystem = subsystem
        self.category = category
        self.level = level
        self.style = style
    }
}

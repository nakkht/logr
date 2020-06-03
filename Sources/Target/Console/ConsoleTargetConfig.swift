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

/// Immutable struct used to encapsulate consolet target configuration values
public struct ConsoleTargetConfig {
    
    /// Subsystem name value assigned during initialization. Used for OSLog configuration.
    public let subsystem: String
    
    /// Category name value assigned during initialization. Used for OSLog configuration.
    public let category: String
    
    /// Logging levels value assigned during initialization.
    public let levels: [LogLevel]
    
    /// Logging style value assigned during initialization.
    public let style: Style
    
    /**
     Initialzes configuration struct with provided values.
     
     - Parameters:
        - substystem: title of OSLog subsystem. Helps to distinguish logs within Console logs. Defaults to: com.neqsoft.logr
        - category: title of OSLog category. Helps to distinguish logs within Console logs. Defaults to: ConsoleTarget
        - levels: array of log levels, which shall be logged
        - style: logging style. Defaults to: minimal style
     */
    public init(subsystem: String? = nil, category: String? = nil, levels: [LogLevel]? = nil, style: Style? = nil) {
        self.subsystem = subsystem ?? "com.neqsoft.logr"
        self.category = category ?? "ConsoleTarget"
        self.levels = levels ?? LogLevel.allCases
        self.style = style ?? .minimal
    }
}

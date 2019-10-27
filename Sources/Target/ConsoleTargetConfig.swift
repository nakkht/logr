//
//  ConsoleTargetConfig.swift
//  Logr
//
//  Created by Paulius Gudonis on 13/09/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
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

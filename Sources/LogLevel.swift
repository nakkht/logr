//
//  LogLevel.swift
//  loggy
//
//  Created by Paulius Gudonis on 28/06/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

/// Enum containing available distinct log levels within library.
public enum LogLevel: Int, Equatable, CaseIterable {
    
    /// Denotes verbose log level
    case debug = 0
    
    /// Denotes informational log level
    case info = 1
    
    /// Denotes warning log level
    case warn = 2
    
    /// Denotes error log level
    case error = 3
    
    /// Denotes critical log level
    case critical = 4
    
    /// String representation of the log level.
    public var title: String {
        switch self {
        case .debug: return "Debug"
        case .info: return "Info"
        case .warn: return "Warn"
        case .error: return "Error"
        case .critical: return "Critical"
        }
    }
}

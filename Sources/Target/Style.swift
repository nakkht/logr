//
//  Style.swift
//  Logr
//
//  Created by Paulius Gudonis on 16/09/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

/// Enum descibing logging styles.
public enum Style {
    
    /// Minimal style denotes short logging style, where only message and level are logged.
    case minimal
    
    /// Verbose style denotes excessive logging style, including, but not limited to message, log level and meta information.
    case verbose
}

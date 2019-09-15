//
//  ConsoleTargetConfig.swift
//  Logr
//
//  Created by Paulius Gudonis on 13/09/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public struct ConsoleTargetConfig {
    
    public let subsystem: String
    public let category: String
    public let levels: [LogLevel]
    
    public init(subsystem: String? = nil, category: String? = nil, levels: [LogLevel]? = nil) {
        self.subsystem = subsystem ?? "com.neqsoft.logr"
        self.category = category ?? "ConsoleTarget"
        self.levels = levels ?? LogLevel.allCases
    }
}

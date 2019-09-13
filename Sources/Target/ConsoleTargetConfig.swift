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
    
    init(subsystem: String = "com.neqsoft.logr", category: String = "ConsoleTarget", levels: [LogLevel] = LogLevel.allCases) {
        self.subsystem = subsystem
        self.category = category
        self.levels = levels
    }
}

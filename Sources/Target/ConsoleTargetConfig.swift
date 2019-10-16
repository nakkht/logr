//
//  ConsoleTargetConfig.swift
//  Logr
//
//  Created by Paulius Gudonis on 13/09/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public struct ConsoleTargetConfig {
    
    public var subsystem: String = "com.neqsoft.logr"
    public var category: String = "ConsoleTarget"
    public var levels: [LogLevel] = LogLevel.allCases
    public var style: Style = .minimal
}

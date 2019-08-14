//
//  ConsoleTarget.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation
import os.log

public final class ConsoleTarget: Target {
    
    @available(iOS 10.0, *)
    private lazy var osLog = OSLog(subsystem: subsystem, category: category)
    
    let subsystem: String
    let category: String
    
    public init(subsystem: String = "com.neqsoft.logr", category: String = "ConsoleTarget") {
        self.subsystem = subsystem
        self.category = category
    }
    
    public func send(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        if #available(iOS 10.0, *) {
            os_log("%{public}@ %{public}@ %{public}d %{public}@ %{public}@", log: osLog, type: OSLogType.from(level), file, function, line, level.title, message)
        } else {
            NSLog("%@", "\(file) \(function) \(line) \(level.title) \(message)")
        }
    }
}

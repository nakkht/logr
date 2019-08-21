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
    lazy var osLog = OSLog(subsystem: subsystem, category: category)
    
    let subsystem: String
    let category: String
    
    public init(subsystem: String = "com.neqsoft.logr", category: String = "ConsoleTarget") {
        self.subsystem = subsystem
        self.category = category
    }
    
    public func send(_ level: LogLevel, _ message: String, _ metaInfo: MetaInfo) {
        if #available(iOS 10.0, *) {
            os_log("%{public}@ %{public}@ %{public}d %{public}@ %{public}@", log: osLog, type: OSLogType.from(level), metaInfo.file, metaInfo.function, metaInfo.line, level.title, message)
        } else {
            NSLog("%@", "\(metaInfo.file) \(metaInfo.function) \(metaInfo.line) \(level.title) \(message)")
        }
    }
}

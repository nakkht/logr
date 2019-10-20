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
    lazy var osLog = OSLog(subsystem: self.config.subsystem, category: self.config.category)
    
    let config: ConsoleTargetConfig
    
    public init(_ config: ConsoleTargetConfig? = nil) {
        self.config = config ?? ConsoleTargetConfig()
    }
    
    public func send(_ message: Message) {
        guard self.config.levels.contains(message.level) else { return }
        if #available(iOS 10.0, *) {
            osLog(message.level, message.text, message.meta)
        } else {
            nsLog(message.level, message.text, message.meta)
        }
    }
    
    @available(iOS 10.0, *)
    func osLog(_ level: LogLevel, _ message: String, _ metaInfo: MetaInfo) {
        if(self.config.style == .verbose) {
            os_log("%{public}@ %{public}@ %{public}d %{public}@: %{public}@", log: osLog, type: OSLogType.from(level), metaInfo.file, metaInfo.function, metaInfo.line, level.title, message)
        } else {
            os_log("%{public}@: %{public}@", log: osLog, type: OSLogType.from(level), level.title, message)
        }
    }
    
    func nsLog(_ level: LogLevel, _ message: String, _ metaInfo: MetaInfo) {
        let metaText = self.config.style == .verbose ? "\(metaInfo.text) " : ""
        NSLog("%@", "\(metaText)\(level.title): \(message)")
    }
}

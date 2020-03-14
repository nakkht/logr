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
import os.log

/// Target class used for logging to unified logging system: i.e. console/Apple Log system facility.
open class ConsoleTarget: Target {
    
    @available(iOS 10.0, *)
    lazy var osLog = OSLog(subsystem: self.config.subsystem, category: self.config.category)
    
    /// Configuration struct assigned during initialization.
    public let config: ConsoleTargetConfig
    
    /**
     Initializes ConsoleTarget instance with provided ConsoleTargetConfig struct.
     
     - Parameters:
        - config: struct encapsulating logging preferences. Defaults to struct instance with defaults values.
     */
    public init(_ config: ConsoleTargetConfig? = nil) {
        self.config = config ?? ConsoleTargetConfig()
    }
    
    open func send(_ message: Message) {
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

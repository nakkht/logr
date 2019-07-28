//
//  ConsoleTarget.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation
import os.log

final class ConsoleTarget: Target {
    
    @available(iOS 10.0, *)
    private lazy var osLog = OSLog(subsystem: subsystem, category: category)
    
    var subsystem: String = ""
    var category: String = ""
    
    func send(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        let formattedMessage = "\(file) \(function) \(line) \(level.title) \(message)"
        if #available(iOS 10.0, *) {
            os_log("%@", log: osLog, type: OSLogType.from(level), formattedMessage)
        } else {
            NSLog("%@", formattedMessage)
        }
    }
}

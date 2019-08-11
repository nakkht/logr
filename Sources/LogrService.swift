//
//  LogrService.swift
//  Logr
//
//  Created by Paulius Gudonis on 22/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public class LogrService {
    
    static let queueName = "com.neqsoft.logr_service"
    static let dispatchQueue = DispatchQueue(label: queueName, qos: .background)
    static var targets: [Target]?
    
    let async: Bool
    
    public init(with config: Config? = nil) {
        self.async = config?.async ?? true
        LogrService.targets = config?.targets
    }
    
    public func log(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        async ? LogrService.dispatchQueue.async {
            self.dispatchLog(level, message: message, file: file, function: function, line: line)
        } : LogrService.dispatchQueue.sync {
            self.dispatchLog(level, message: message, file: file, function: function, line: line)
        }
    }
    
    func dispatchLog(_ level: LogLevel, message: String, file: String, function: String, line: Int) {
        LogrService.targets?.forEach({
            $0.send(level, message: message, file: file, function: function, line: line)
        })
    }
}

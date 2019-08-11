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
        LogrService.targets?.forEach({ (target) in
            dispatch({
                target.send(level, message: message, file: file, function: function, line: line)
            })
        })
        
    }
    
    func dispatch(_ block: @escaping () -> Void) {
        async ? LogrService.dispatchQueue.async { block() } : LogrService.dispatchQueue.sync { block() }
    }
}

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
    
    public init() {}
    
    @discardableResult
    public convenience init(with config: Config) {
        self.init()
        LogrService.targets = config.targets
    }
    
    public func log(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line, async: Bool = true) {
        LogrService.targets?.forEach({ (target) in
            dispatch({
                target.send(level, message: message, file: file, function: function, line: line)
            }, async)
        })
        
    }
    
    private func dispatch(_ block: @escaping () -> Void,  _ async: Bool) {
        async ? LogrService.dispatchQueue.async { block() } : LogrService.dispatchQueue.sync { block() }
    }
}

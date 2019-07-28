//
//  LogrService.swift
//  Logr
//
//  Created by Paulius Gudonis on 22/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

final class LogrService {
    
    private static let queueName = "com.neqsoft.logr_service"
    private static let dispatchQueue = DispatchQueue(label: queueName, qos: .background)
    private static var targets: [Target]?
    
    init() {}
    
    static func `init`(with config: Config) {
        targets = config.targets
    }
    
    func log(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line, _ async: Bool = true) {
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

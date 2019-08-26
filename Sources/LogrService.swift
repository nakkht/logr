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
    
    init() {
        async = true
    }
    
    @discardableResult
    public init(with config: Config) {
        self.async = config.async
        LogrService.targets = config.targets
    }
    
    public func log(_ level: LogLevel, _ message: String, _ metaInfo: MetaInfo) {
        async ? LogrService.dispatchQueue.async {
            self.dispatchLog(level, message, metaInfo)
        } : LogrService.dispatchQueue.sync {
            self.dispatchLog(level, message, metaInfo)
        }
    }
    
    func dispatchLog(_ level: LogLevel, _ message: String, _ metaInfo: MetaInfo) {
        LogrService.targets?.forEach({
            $0.send(level, message, metaInfo)
        })
    }
}

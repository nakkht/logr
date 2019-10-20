//
//  LogrService.swift
//  Logr
//
//  Created by Paulius Gudonis on 22/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public class LogrService {
    
    static var dispatchQueue = DispatchQueue(label: "com.neqsoft.logr_service", qos: .background)
    static var targets: [Target]?
    
    let async: Bool
    
    init() {
        self.async = true
    }
    
    @discardableResult
    public init(with config: Config) {
        self.async = config.async
        LogrService.targets = config.targets
        if let configDispatchQueue = config.dispatchQueue {
            LogrService.dispatchQueue = configDispatchQueue
        }
    }
    
    public func log(_ message: Message) {
        if(async) {
            LogrService.dispatchQueue.async { self.dispatchLog(message) }
        } else {
            LogrService.dispatchQueue.sync { self.dispatchLog(message) }
        }
    }
    
    func dispatchLog(_ message: Message) {
        LogrService.targets?.forEach { $0.send(message) }
    }
}

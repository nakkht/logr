//
//  LogrService.swift
//  Logr
//
//  Created by Paulius Gudonis on 22/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

class LogrService {
    
    private static let queueName = "com.neqsoft.logr_service"
    private static let dispatchQueue = DispatchQueue(label: queueName, qos: .background)
    
    func log(_ level: LogLevel, _ message: String, _ async: Bool = true) {
        if(async) {
            LogrService.dispatchQueue.async { }
        } else {
            LogrService.dispatchQueue.sync { }
        }
    }
}

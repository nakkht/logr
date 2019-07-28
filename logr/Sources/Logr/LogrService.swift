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
    private static let targets = [Target]()
    
    func log(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line, _ async: Bool = true) {
        if(async) {
            LogrService.dispatchQueue.async { }
        } else {
            LogrService.dispatchQueue.sync { }
        }
    }
}

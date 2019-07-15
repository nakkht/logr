//
//  Loggy.swift
//  loggy
//
//  Created by Paulius Gudonis on 28/06/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

class Loggy {
    
    private static var localLoggerQueue: DispatchQueue?
    
    init() {
        initLogger()
    }
    
    private func initLogger() {
        if Loggy.localLoggerQueue == nil {
            Loggy.localLoggerQueue = DispatchQueue(label: "com.neqsoft.loggy", qos: .background)
        }
    }
    
    func d(_ message: String, _ async: Bool = true) {
        log(.debug, message: message, async)
    }
    
    func i(_ message: String, _ async: Bool = true) {
        log(.info, message: message, async)
    }
    
    func w(_ message: String, _ async: Bool = true) {
        self.log(.warn, message: message, async)
    }
    
    private func log(_ level: LogLevel, message: String, _ async: Bool = true) {
       
    }
}

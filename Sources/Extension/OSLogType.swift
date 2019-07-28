//
//  OSLogType.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation
import os.log

extension OSLogType {
    
    @available(iOS 10.0, *)
    static func from(_ logLevel: LogLevel) -> OSLogType {
        switch logLevel {
        case .debug: return debug
        case .info: return info
        case .warn, .error: return error
        case .critical: return fault
        }
    }
}

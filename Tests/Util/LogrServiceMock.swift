//
//  LogrServiceMock.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 11/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation
@testable import Logr

class LogrServiceMock: LogrService {
    
    var calledLogWith: (level: LogLevel, message: String, file: String, function: String, line: Int)?
    
    public override func log(_ level: LogLevel, message: String, file: String = #file, function: String = #function, line: Int = #line) {
        calledLogWith = (level, message, file, function, line)
    }
    
    deinit {
        LogrService.targets = nil
    }
}

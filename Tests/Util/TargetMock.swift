//
//  TargetMock.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 11/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation
@testable import Logr

class TargetMock: Target {
    
    var calledSendWtih: (level: LogLevel, message: String, file: String, function: String, line: Int)?
    
    func send(_ level: LogLevel, message: String, file: String, function: String, line: Int) {
        calledSendWtih = (level, message, file, function, line)
    }
}

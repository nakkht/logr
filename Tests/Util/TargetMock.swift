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
    
    var calledSendWith: ((_ level: LogLevel, _ message: String, _ metaInfo: MetaInfo) -> Void)?
    
    func send(_ level: LogLevel, _ message: String, _ metaInfo: MetaInfo) {
        calledSendWith?(level, message, metaInfo)
    }
}

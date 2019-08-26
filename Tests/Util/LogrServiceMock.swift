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
    
    var calledLogWith: (level: LogLevel, message: String, metaInfo: MetaInfo)?
    
    public override func log(_ level: LogLevel, _ message: String, _ metaInfo: MetaInfo) {
        calledLogWith = (level, message, metaInfo)
    }
    
    deinit {
        LogrService.targets = nil
    }
}

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
    
    var calledLogWith: (Message)?
    
    public override func log(_ message: Message) {
        calledLogWith = (message)
    }
    
    deinit {
        LogrService.targets = nil
    }
}

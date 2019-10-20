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
    
    var calledSendWith: ((Message) -> Void)?
    
    func send(_ message: Message) {
        calledSendWith?(message)
    }
}

//
//  OsLogTypeTests.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 18/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import XCTest
import os.log
@testable import Logr

@available(iOS 10.0, *)
class OsLogTypeTests: XCTestCase {

    func testDebugCase() {
        let osLogType = OSLogType.from(.debug)
        XCTAssertEqual(.debug, osLogType)
    }
    
    func testInfoCase() {
        let osLogType = OSLogType.from(.info)
        XCTAssertEqual(.info, osLogType)
    }
    
    func testErrorWarnCase() {
        let osLogType = OSLogType.from(.error)
        XCTAssertEqual(.error, osLogType)
    }
    
    func testWarnCase() {
        let osLogType = OSLogType.from(.warn)
        XCTAssertEqual(.error, osLogType)
    }
    
    func testCriticalCase() {
        let osLogType = OSLogType.from(.critical)
        XCTAssertEqual(.fault, osLogType)
    }
}

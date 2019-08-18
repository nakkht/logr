//
//  LogLevelTests.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 18/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import XCTest
@testable import Logr

class LogLevelTests: XCTestCase {
    
    var logLevel: LogLevel!

    override func setUp() {
    }

    override func tearDown() {
        logLevel = nil
    }

    func testDebugCase() {
        logLevel = LogLevel(rawValue: 0)
        
        XCTAssertEqual(.debug, logLevel)
        XCTAssertEqual("Debug", logLevel.title)
    }
    
    func testInfoCase() {
        logLevel = LogLevel(rawValue: 1)
        
        XCTAssertEqual(.info, logLevel)
        XCTAssertEqual("Info", logLevel.title)
    }
    
    func testWarnCase() {
        logLevel = LogLevel(rawValue: 2)
        
        XCTAssertEqual(.warn, logLevel)
        XCTAssertEqual("Warn", logLevel.title)
    }
    
    func testErrorCase() {
        logLevel = LogLevel(rawValue: 3)
        
        XCTAssertEqual(.error, logLevel)
        XCTAssertEqual("Error", logLevel.title)
    }
    
    func testCriticalCase() {
        logLevel = LogLevel(rawValue: 4)
        
        XCTAssertEqual(.critical, logLevel)
        XCTAssertEqual("Critical", logLevel.title)
    }
}

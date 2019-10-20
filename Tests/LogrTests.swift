//
//  LogrTests.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 08/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import XCTest
@testable import Logr

class LogrTests: XCTestCase {
    
    var mock: LogrServiceMock!
    var logr: Logr!

    override func setUp() {
        mock = LogrServiceMock()
        logr = Logr(mock)
    
        XCTAssertTrue(mock === logr.service)
    }

    override func tearDown() {
        logr = nil
    }
    
    func testDefaultValues() {
        logr = Logr()
        XCTAssertNotNil(logr.service)
    }

    func testDebug() {
        let message = "debug message"
        logr.debug(message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.debug, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.text)
    }
    
    func testInfo() {
        let message = "info message"
        logr.info(message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.info, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.text)
    }

    func testWarn() {
        let message = "warn message"
        logr.warn(message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.warn, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.text)
    }

    func testError() {
        let message = "error message"
        logr.error(message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.error, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.text)
    }

    func testCritical() {
        let message = "critical message"
        logr.critical(message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.critical, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.text)
    }
}

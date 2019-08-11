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
    
    var logr: Logr!

    override func setUp() {
        logr = Logr()
    }

    override func tearDown() {
        logr = nil
    }

    func testDefaulValues() {
        XCTAssertNotNil(logr.service)
    }
    
    func testCustomValues() {
        let testService = LogrService()
        let logr = Logr(testService)
        
        XCTAssertTrue(testService === logr.service)
    }
    
    func testDebug() {
        let mock = LogrServiceMock()
        let logr = Logr(mock)
        let message = "debug message"
        logr.debug(message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.debug, mock.calledLogWith?.0)
        XCTAssertEqual(message, mock.calledLogWith?.1)
    }
    
    func testInfo() {
        let mock = LogrServiceMock()
        let logr = Logr(mock)
        let message = "info message"
        logr.info(message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.info, mock.calledLogWith?.0)
        XCTAssertEqual(message, mock.calledLogWith?.1)
    }

    func testWarn() {
        let mock = LogrServiceMock()
        let logr = Logr(mock)
        let message = "warn message"
        logr.warn(message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.warn, mock.calledLogWith?.0)
        XCTAssertEqual(message, mock.calledLogWith?.1)
    }

    func testError() {
        let mock = LogrServiceMock()
        let logr = Logr(mock)
        let message = "error message"
        logr.error(message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.error, mock.calledLogWith?.0)
        XCTAssertEqual(message, mock.calledLogWith?.1)
    }

    func testCritical() {
        let mock = LogrServiceMock()
        let logr = Logr(mock)
        let message = "critical message"
        logr.critical(message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.critical, mock.calledLogWith?.0)
        XCTAssertEqual(message, mock.calledLogWith?.1)
    }

    func testLog() {
        let mock = LogrServiceMock()
        let logr = Logr(mock)
        let message = "info message"
        
        logr.log(.info, message)
        
        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.info, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.message)
        XCTAssertEqual(#file, mock.calledLogWith?.file)
        XCTAssertEqual("testLog()", mock.calledLogWith?.function)
        XCTAssertEqual(95, mock.calledLogWith?.line)
        XCTAssertEqual(true, mock.calledLogWith?.async)
    }
}

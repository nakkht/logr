//
//  LogrServiceTests.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 11/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import XCTest
@testable import Logr

class LogrServiceTests: XCTestCase {
    
    var service: LogrService!
    var config: Config!
    var targetMock: TargetMock!
    var dispatchQueue: DispatchQueue!

    override func setUp() {
        dispatchQueue = DispatchQueue(label: "com.neqsoft.test_dispatch")
        targetMock = TargetMock()
        config = Config(async: false, dispatchQueue: dispatchQueue, targetMock)
        service = LogrService(with: config)
        XCTAssertEqual(dispatchQueue, LogrService.dispatchQueue)
        XCTAssertNotNil(LogrService.targets)
        XCTAssertEqual(config.targets?.count, LogrService.targets?.count)
    }

    override func tearDown() {
        targetMock = nil
        config = nil
        dispatchQueue = nil
        service = nil
    }
    
    func testDefaultValues() {
        service = LogrService()
        XCTAssertNotNil(LogrService.targets)
    }
    
    func testAsyncLog() {
        service = LogrService(with: Config(targetMock))
        XCTAssertNotNil(LogrService.targets)
        
        let message = "error message"
        let metaInfo = MetaInfo(file: "file", function: "async type of function", line: 42)
        let expectation = XCTestExpectation(description: "Async logging")
        targetMock.calledSendWith = { (receivedLevel, receivedMessage, receivedMeta) in
            
            XCTAssertEqual(LogLevel.error, receivedLevel)
            XCTAssertEqual(message, receivedMessage)
            XCTAssertEqual("file", receivedMeta.file)
            XCTAssertEqual("async type of function", receivedMeta.function)
            XCTAssertEqual(42, receivedMeta.line)
            expectation.fulfill()
        }
        service.log(.error, message, metaInfo)
        wait(for: [expectation], timeout: 1.0)
    }

    func testLog() {
        let message = "error message"
        let metaInfo = MetaInfo(file: "file", function: "sync type of function", line: 42)
        targetMock.calledSendWith = { (receivedLevel, receivedMessage, receivedMeta) in
         
            XCTAssertEqual(LogLevel.error, receivedLevel)
            XCTAssertEqual(message, receivedMessage)
            XCTAssertEqual("file", receivedMeta.file)
            XCTAssertEqual("sync type of function", receivedMeta.function)
            XCTAssertEqual(42, receivedMeta.line)
        }
        service.log(.error, message, metaInfo)
    }
}

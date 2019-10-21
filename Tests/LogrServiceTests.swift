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
        
        let message = Message(level: .error,
                              text: "error message",
                              meta: MetaInfo(file: "file", function: "async type of function", line: 42))
        let expectation = XCTestExpectation(description: "Async logging")
        targetMock.calledSendWith = {
            
            XCTAssertEqual(LogLevel.error, $0.level)
            XCTAssertEqual(message.text, $0.text)
            XCTAssertEqual("file", $0.meta.file)
            XCTAssertEqual("async type of function", $0.meta.function)
            XCTAssertEqual(42, $0.meta.line)
            expectation.fulfill()
        }
        service.log(message)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLog() {
        let message = Message(level: .error,
                              text: "error message",
                              meta:  MetaInfo(file: "file", function: "sync type of function", line: 42))
        targetMock.calledSendWith = {
            
            XCTAssertEqual(LogLevel.error, $0.level)
            XCTAssertEqual(message.text, $0.text)
            XCTAssertEqual("file", $0.meta.file)
            XCTAssertEqual("sync type of function", $0.meta.function)
            XCTAssertEqual(42, $0.meta.line)
        }
        service.log(message)
    }
}

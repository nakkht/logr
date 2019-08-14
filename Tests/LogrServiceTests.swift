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

    override func setUp() {
        targetMock = TargetMock()
        config = Config(async: false, targetMock)
        service = LogrService(with: config)
        XCTAssertNotNil(LogrService.targets)
        XCTAssertEqual(config.targets?.count, LogrService.targets?.count)
    }

    override func tearDown() {
        service = nil
    }
    
    func testDefaultValues() {
        service = LogrService()
        XCTAssertNotNil(LogrService.targets)
    }

    func testLog() {
        let message = "error message"
        service.log(.error, message: message)
        
        XCTAssertNotNil(targetMock.calledSendWtih)
        XCTAssertEqual(LogLevel.error, targetMock.calledSendWtih?.level)
        XCTAssertEqual(message, targetMock.calledSendWtih?.message)
        XCTAssertEqual(#file, targetMock.calledSendWtih?.file)
        XCTAssertEqual(#function, targetMock.calledSendWtih?.function)
        XCTAssertEqual(37, targetMock.calledSendWtih?.line)
    }
}

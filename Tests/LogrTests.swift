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
        XCTFail()
    }
    
    func tesInfo() {
        XCTFail()
    }
    
    func testWarn() {
        XCTFail()
    }
    
    func testError() {
        XCTFail()
    }
    
    func testCritical() {
        XCTFail()
    }
    
    func testLog() {
        XCTFail()
    }
}

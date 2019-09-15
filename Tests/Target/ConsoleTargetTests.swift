//
//  ConsoleTargetTests.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 04/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import XCTest
@testable import Logr

class ConsoleTargetTests: XCTestCase {
    
    var target: ConsoleTarget!
    
    override func setUp() {
        target = ConsoleTarget()
        XCTAssertEqual("com.neqsoft.logr", target.config.subsystem)
        XCTAssertEqual("ConsoleTarget", target.config.category)
    }
    
    override func tearDown() {
        target = nil
    }
    
    func testSetValues() {
        let config = ConsoleTargetConfig(subsystem: "logging_subsystem", category: "logging_category", levels: [.warn])
        let target = ConsoleTarget(config)
        
        XCTAssertEqual(target.config.category, config.category)
        XCTAssertEqual(target.config.subsystem, config.subsystem)
        XCTAssertEqual(target.config.levels, config.levels)
    }
}

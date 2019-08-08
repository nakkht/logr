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
    }

    override func tearDown() {
        target = nil
    }

    func testDefautValues() {
        XCTAssertEqual(target.category, "")
        XCTAssertEqual(target.subsystem, "")
    }
    
    func testSetValues() {
        let subsystem = "logging_subsystem"
        let category = "logging_category"
        let target = ConsoleTarget(subsystem: subsystem, category: category)
        
        XCTAssertEqual(target.category, category)
        XCTAssertEqual(target.subsystem, subsystem)
    }
}

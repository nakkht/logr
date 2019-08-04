//
//  ConsoleTargetTests.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 04/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import XCTest
import Logr

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
}

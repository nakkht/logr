//
//  ConfigTests.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 11/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import XCTest
@testable import Logr

class ConfigTests: XCTestCase {
    
    var config: Config!

    override func setUp() {
        config = Config()
        
        XCTAssertNil(config.targets)
        XCTAssertTrue(config.async)
    }

    override func tearDown() {
        config = nil
    }
    
    func testAsyncSetup() {
        config = Config(async: false)
        
        XCTAssertNil(config.targets)
        XCTAssertFalse(config.async)
    }

    func testTargetSetup() {
        let targets = Array(repeating: TargetMock(), count: 300)
        config = Config(targets: targets)
        
        XCTAssertEqual(300, targets.count)
    }
}

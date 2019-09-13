//
//  FileTargetTests.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 22/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import XCTest
@testable import Logr

class FileTargetTests: XCTestCase {
    
    var fileTarget: FileTarget!

    override func setUp() {
        fileTarget = FileTarget()
        
        XCTAssertNotNil(fileTarget.fileHandle)
        XCTAssertNotNil(fileTarget.config)
    }

    override func tearDown() {
        fileTarget = nil
    }
}

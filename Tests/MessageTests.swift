//
//  LogrServiceMock.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 11/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

import XCTest
@testable import Logr

class MessageTests: XCTestCase {
    
    var message: Message!
    
    override func tearDown() {
        message = nil
    }
    
    func testSetValues() {
        let logMessage = "log message"
        let metaInfo = MetaInfo(file: "fileName",
                                function: "function",
                                line: 42)
        message = Message(level: .error, text: logMessage, meta: metaInfo)
        
        XCTAssertNotNil(message)
        XCTAssertEqual(.error, message.level)
        XCTAssertEqual(logMessage, message.text)
        XCTAssertEqual(metaInfo, message.meta)
        XCTAssertEqual(message.metaText, message.meta.text)
    }
}

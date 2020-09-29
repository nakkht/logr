//
// Copyright 2020 Paulius Gudonis
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// 

import XCTest
@testable import Logr

class LogLevelTests: XCTestCase {
    
    var logLevel: LogLevel!

    override func setUp() {
    }

    override func tearDown() {
        logLevel = nil
    }

    func testDebugCase() {
        logLevel = LogLevel(rawValue: 0)
        
        XCTAssertEqual(.debug, logLevel)
        XCTAssertEqual("Debug", logLevel.description)
    }
    
    func testInfoCase() {
        logLevel = LogLevel(rawValue: 1)
        
        XCTAssertEqual(.info, logLevel)
        XCTAssertEqual("Info", logLevel.description)
    }
    
    func testWarnCase() {
        logLevel = LogLevel(rawValue: 2)
        
        XCTAssertEqual(.warn, logLevel)
        XCTAssertEqual("Warn", logLevel.description)
    }
    
    func testErrorCase() {
        logLevel = LogLevel(rawValue: 3)
        
        XCTAssertEqual(.error, logLevel)
        XCTAssertEqual("Error", logLevel.description)
    }
    
    func testCriticalCase() {
        logLevel = LogLevel(rawValue: 4)
        
        XCTAssertEqual(.critical, logLevel)
        XCTAssertEqual("Critical", logLevel.description)
    }
}

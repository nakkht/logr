//
// Copyright 2020 Paulius Gudonis, neqsoft
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

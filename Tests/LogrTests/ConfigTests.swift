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

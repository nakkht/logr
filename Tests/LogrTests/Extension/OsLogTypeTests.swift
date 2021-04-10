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
import os.log
@testable import Logr

@available(iOS 10.0, tvOS 10.0, macOS 10.12, *)
class OsLogTypeTests: XCTestCase {

    func testDebugCase() {
        let osLogType = OSLogType.from(.debug)
        XCTAssertEqual(.debug, osLogType)
    }

    func testInfoCase() {
        let osLogType = OSLogType.from(.info)
        XCTAssertEqual(.info, osLogType)
    }

    func testErrorWarnCase() {
        let osLogType = OSLogType.from(.error)
        XCTAssertEqual(.error, osLogType)
    }

    func testWarnCase() {
        let osLogType = OSLogType.from(.warn)
        XCTAssertEqual(.error, osLogType)
    }

    func testCriticalCase() {
        let osLogType = OSLogType.from(.critical)
        XCTAssertEqual(.fault, osLogType)
    }
}

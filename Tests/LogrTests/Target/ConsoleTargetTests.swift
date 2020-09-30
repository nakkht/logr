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

class ConsoleTargetTests: XCTestCase {
    
    var target: ConsoleTarget!
    
    override func setUp() {
        target = ConsoleTarget()
        XCTAssertEqual("com.neqsoft.logr", target.config.subsystem)
        XCTAssertEqual("ConsoleTarget", target.config.category)
        XCTAssertEqual(.debug, target.config.level)
        XCTAssertEqual(.minimal, target.config.style)
    }
    
    override func tearDown() {
        target = nil
    }
    
    func testConfigValues() {
        let config = ConsoleTargetConfig(subsystem: "logging_subsystem", category: "logging_category", level: .warn)
        let target = ConsoleTarget(config)
        
        XCTAssertEqual(config.category, target.config.category)
        XCTAssertEqual(config.subsystem, target.config.subsystem)
        XCTAssertEqual(config.level, target.config.level)
        XCTAssertEqual(config.style, target.config.style)
    }

    func testOsLogMinimal() {
        XCTAssertEqual(.minimal, target.config.style)
        messages.forEach { target.send($0) }
    }

    func testOsLogVerbose() {
        let config = ConsoleTargetConfig(subsystem: "logging_subsystem", category: "logging_category", style: .verbose)
        let target = ConsoleTarget(config)
        
        XCTAssertEqual(.verbose, target.config.style)
        messages.forEach { target.send($0) }
    }
    
    func testLevels() {
        let config = ConsoleTargetConfig(subsystem: "logging_subsystem", category: "logging_category", level: .info)
        let target = ConsoleTarget(config)
        
        XCTAssertEqual(.minimal, target.config.style)
        messages.forEach { target.send($0) }
    }
    
    func testNsLogMinimal() {
        XCTAssertEqual(.minimal, target.config.style)
        messages.forEach { target.nsLog($0) }
    }
    
    func testNsLogVerbose() {
        let config = ConsoleTargetConfig(subsystem: "logging_subsystem", category: "logging_category", style: .verbose)
        let target = ConsoleTarget(config)
        
        XCTAssertEqual(.verbose, target.config.style)
        messages.forEach { target.nsLog($0) }
    }

    var messages = [
        Message(level: .debug, tag: "ConsoleTargetTest", text: "debug message", meta: MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())),
        Message(level: .info, tag: "ConsoleTargetTest", text: "info message", meta: MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())),
        Message(level: .warn, tag: "ConsoleTargetTest", text: "warn message", meta: MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())),
        Message(level: .error, tag: "ConsoleTargetTest", text: "error message", meta: MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())),
        Message(level: .critical, tag: "ConsoleTargetTest", text: "info message", meta: MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date()))
    ]
}

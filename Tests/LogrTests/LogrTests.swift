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

class LogrTests: XCTestCase {

    var mock: LogrServiceMock!
    var tag: String!
    var logr: Logr!

    override func setUp() {
        mock = LogrServiceMock()
        tag = String(describing: self)
        logr = Logr(tag, mock)

        XCTAssertTrue(mock === logr.service)
    }

    override func tearDown() {
        logr = nil
    }

    func testDefaultValues() {
        logr = Logr()
        XCTAssertNotNil(logr.service)
        XCTAssertEqual("LogrTests", logr.tag)
    }

    func testRandomTags() {
        ["tag", "specific.tag"].forEach {
            let logr = Logr($0)
            XCTAssertEqual($0, logr.tag)
        }
    }

    func testDebug() {
        let message = "debug message"
        logr.debug(message)

        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.debug, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.text)
    }

    func testInfo() {
        let message = "info message"
        logr.info(message)

        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.info, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.text)
    }

    func testWarn() {
        let message = "warn message"
        logr.warn(message)

        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.warn, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.text)
    }

    func testError() {
        let message = "error message"
        logr.error(message)

        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.error, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.text)
    }

    func testCritical() {
        let message = "critical message"
        logr.critical(message)

        XCTAssertNotNil(mock.calledLogWith)
        XCTAssertEqual(LogLevel.critical, mock.calledLogWith?.level)
        XCTAssertEqual(message, mock.calledLogWith?.text)
    }
}

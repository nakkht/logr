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

class LogrServiceTests: XCTestCase {
    
    var service: LogrService!
    var config: Config!
    var targetMock: TargetMock!
    var defaultDispatchQueue: DispatchQueue!
    
    override func setUp() {
        targetMock = TargetMock()
        defaultDispatchQueue = LogrService.dispatchQueue
    }
    
    override func tearDown() {
        targetMock = nil
        config = nil
        service = nil
        LogrService.dispatchQueue = defaultDispatchQueue
        LogrService.targets = nil
    }
    
    func testDefaultValues() {
        service = LogrService()
        XCTAssertNil(LogrService.targets)
        XCTAssertEqual("logr.service", LogrService.dispatchQueue.label)
        XCTAssertTrue(service.async)
    }
    
    func testDispatchQueue() {
        let dispatchQueue = DispatchQueue(label: "logr.test-dispatch")
        config = Config(async: false, targetMock)
        service = LogrService(with: config, dispatchQueue: dispatchQueue)
        XCTAssertEqual(dispatchQueue, LogrService.dispatchQueue)
        XCTAssertNotNil(LogrService.targets)
        XCTAssertEqual(config.targets?.count, LogrService.targets?.count)
    }
    
    func testSyncLog() {
        service = LogrService(with: Config(async: false, targetMock))
        XCTAssertNotNil(LogrService.targets)
        let metaInfo = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        let message = Message(level: .error,
                              tag: String(describing: self),
                              text: "error message",
                              meta: metaInfo)
        targetMock.calledSendWith = {
            XCTAssertEqual(message, $0)
            XCTAssertEqual(metaInfo, $0.meta)
        }
        service.log(message)
    }
    
    func testAsyncLog() {
        service = LogrService(with: Config(targetMock))
        XCTAssertNotNil(LogrService.targets)
        let metaInfo = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        let message = Message(level: .error,
                              tag: String(describing: self),
                              text: "error message",
                              meta: metaInfo)
        let expectation = XCTestExpectation(description: "Async logging")
        targetMock.calledSendWith = {
            XCTAssertEqual(message, $0)
            XCTAssertEqual(metaInfo, $0.meta)
            expectation.fulfill()
        }
        service.log(message)
        wait(for: [expectation], timeout: 1.0)
    }
}

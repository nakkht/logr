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

import Foundation

import XCTest
@testable import Logr

class MessageTests: XCTestCase {
    
    func testSetValues() {
        let logMessage = "log message"
        let tag = String(describing: self)
        let metaInfo = MetaInfo(file: "fileName",
                                function: "function",
                                line: 42)
        let message = Message(level: .error,
                          tag: tag,
                          text: logMessage,
                          meta: metaInfo)
        
        XCTAssertNotNil(message)
        XCTAssertEqual(.error, message.level)
        XCTAssertEqual(logMessage, message.text)
        XCTAssertEqual(tag, message.tag)
        XCTAssertEqual(metaInfo, message.meta)
        XCTAssertEqual(metaInfo.text, message.meta.text)
    }
    
    func testMetaInfo() {
        let file = ""
        let function = #function
        let line = #line
        let metaInfo = MetaInfo(file: file, function: function, line: line)
        
        XCTAssertEqual(file, metaInfo.file)
        XCTAssertEqual(function, metaInfo.function)
        XCTAssertEqual(line, metaInfo.line)
        XCTAssertEqual("", metaInfo.fileName)
    }
}

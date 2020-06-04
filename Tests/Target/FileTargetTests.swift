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

class FileTargetTests: XCTestCase {
    
    var fileManager: FileManager!
    var fileTarget: FileTarget!
    var targetConfig: FileTargetConfig!
    
    override func setUp() {
        fileManager = FileManager.default
        fileTarget = FileTarget()
        
        XCTAssertNotNil(fileTarget.fileHandle)
        XCTAssertNotNil(fileTarget.config)
        
        targetConfig = FileTargetConfig()
        
        XCTAssertEqual("log", targetConfig.fileExtension)
        XCTAssertEqual("file", targetConfig.fileName)
        XCTAssertEqual(TimeSpan.day, targetConfig.archiveFrequency)
        XCTAssertEqual(FileTargetConfig.defaultMaxFileSizeInBytes, targetConfig.maxFileSizeInBytes)
        XCTAssertEqual("file.log", targetConfig.fullFileName)
        XCTAssertEqual("file.0.log", targetConfig.archiveFileName)
        XCTAssertEqual(Style.minimal, targetConfig.style)
        XCTAssertEqual(.debug, targetConfig.level)
        XCTAssertEqual(1, targetConfig.maxArchivedFilesCount)
    }
    
    override func tearDown() {
        try! FileManager.default.removeItem(at: fileTarget.fullLogFileUrl)
        try! FileManager.default.removeItem(at: fileTarget.archiveUrl)
        fileTarget = nil
        targetConfig = nil
        fileManager = nil
    }
    
    func testConfig() {
        let size = UInt64(100 * 1024 * 1024)
        let fileExtension = "longextension"
        let fileName = "long-file-name"
        targetConfig = FileTargetConfig(fileName: fileName, fileExtension: fileExtension, maxArchivedFilesCount: 100,
                                        maxFileSizeInBytes: size ,style: .verbose)
        
        XCTAssertEqual(fileExtension, targetConfig.fileExtension)
        XCTAssertEqual(fileName, targetConfig.fileName)
        XCTAssertEqual(size, targetConfig.maxFileSizeInBytes)
        XCTAssertEqual(.verbose, targetConfig.style)
        XCTAssertEqual("\(fileName).\(fileExtension)", targetConfig.fullFileName)
        XCTAssertEqual(100, targetConfig.maxArchivedFilesCount)
        XCTAssertEqual("\(fileName).0.\(fileExtension)", targetConfig.archiveFileName)
    }
    
    func testSetArchiveFrequency() {
        TimeSpan.allCases.forEach {
            targetConfig = FileTargetConfig(archiveFrequency: $0)
            XCTAssertEqual($0, targetConfig.archiveFrequency)
        }
    }
    
    func testManualArchive() {
        XCTAssertTrue(fileTarget.doesLogFileExists)
        XCTAssertEqual(0, fileTarget.logFileSizeInBytes)
        let lineCount = 10_000
        let expectation = XCTestExpectation(description: "Complete logging")
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            let debugMessage = Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta)
            let infoMessage = Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta)
            let warnMessage = Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta)
            let errorMessage = Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta)
            let criticalMessage = Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta)
            fileTarget.send(debugMessage)
            fileTarget.send(infoMessage)
            fileTarget.send(warnMessage)
            fileTarget.send(errorMessage)
            fileTarget.send(criticalMessage)
        }
        fileTarget.archive {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
        let archivedFileUrl = fileTarget.archiveUrl.appendingPathComponent(self.targetConfig.archiveFileName)
        let archivedFileSize = try! fileManager.attributesOfItem(atPath: archivedFileUrl.path)[.size] as? UInt64
        XCTAssertEqual(2554450, archivedFileSize)
        let archivedLines = try! String(contentsOf: archivedFileUrl, encoding: .utf8).components(separatedBy: .newlines)
        stride(from: 0, to: lineCount, by: 5).enumerated().forEach {
            XCTAssertTrue(archivedLines[$0.element].contains("Test - Debug: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 1].contains("Test - Info: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 2].contains("Test - Warn: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 3].contains("Test - Error: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 4].contains("Test - Critical: message #\($0.offset)"))
        }
    }
}

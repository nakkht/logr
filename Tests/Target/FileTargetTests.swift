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
    
    var target: FileTarget!
    var targetConfig: FileTargetConfig!
    
    override func setUp() {
        target = FileTarget()
        
        XCTAssertNotNil(target.fileHandle)
        XCTAssertNotNil(target.config)
        XCTAssertTrue(target.doesLogFileExists)
        XCTAssertEqual(0, target.logFileSizeInBytes)
        
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
        try! target.fileManager.removeItem(at: target.fullLogFileUrl)
        try! target.fileManager.removeItem(at: target.archiveUrl)
        target = nil
        targetConfig = nil
    }
    
    func testConfig() {
        let size = UInt64(100 * 1024 * 1024)
        let fileExtension = "longextension"
        let fileName = "long-file-name"
        let targetConfig = FileTargetConfig(fileName: fileName, fileExtension: fileExtension, maxArchivedFilesCount: 100,
                                            maxFileSizeInBytes: size ,style: .verbose)
        
        XCTAssertEqual(fileExtension, targetConfig.fileExtension)
        XCTAssertEqual(fileName, targetConfig.fileName)
        XCTAssertEqual(size, targetConfig.maxFileSizeInBytes)
        XCTAssertEqual(.verbose, targetConfig.style)
        XCTAssertEqual("\(fileName).\(fileExtension)", targetConfig.fullFileName)
        XCTAssertEqual(100, targetConfig.maxArchivedFilesCount)
        XCTAssertEqual("\(fileName).0.\(fileExtension)", targetConfig.archiveFileName)
    }
    
    func testManualArchive() {
        let lineCount = 1000
        let expectation = XCTestExpectation(description: "Writing \(lineCount) log lines")
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            let debugMessage = Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta)
            let infoMessage = Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta)
            let warnMessage = Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta)
            let errorMessage = Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta)
            let criticalMessage = Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta)
            target.send(debugMessage)
            target.send(infoMessage)
            target.send(warnMessage)
            target.send(errorMessage)
            target.send(criticalMessage)
        }
        target.archive {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 120.0)
        let archivedFileUrl = target.archiveUrl.appendingPathComponent(self.targetConfig.archiveFileName)
        let archivedLines = try! String(contentsOf: archivedFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(lineCount * 5, archivedLines.count)
        stride(from: 0, to: lineCount, by: 5).enumerated().forEach {
            XCTAssertTrue(archivedLines[$0.element].contains("Debug - Test: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 1].contains("Info - Test: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 2].contains("Warn - Test: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 3].contains("Error - Test: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 4].contains("Critical - Test: message #\($0.offset)"))
        }
    }
    
    func testSerialDispatchQueue() {
        let dispatchQueue = DispatchQueue(label: "test.queue")
        targetConfig = FileTargetConfig(dispatchQueue: dispatchQueue)
        target = FileTarget(targetConfig)
        let lineCount = 10
        let expectation = XCTestExpectation(description: "Writing \(lineCount) log lines using serial queue")
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            let debugMessage = Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta)
            let infoMessage = Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta)
            let warnMessage = Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta)
            let errorMessage = Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta)
            let criticalMessage = Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta)
            target.send(debugMessage)
            target.send(infoMessage)
            target.send(warnMessage)
            target.send(errorMessage)
            target.send(criticalMessage)
        }
        target.archive {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
        let archivedFileUrl = target.archiveUrl.appendingPathComponent(self.targetConfig.archiveFileName)
        let archivedLines = try! String(contentsOf: archivedFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(lineCount * 5, archivedLines.count)
        stride(from: 0, to: lineCount, by: 5).enumerated().forEach {
            XCTAssertTrue(archivedLines[$0.element].contains("Debug - Test: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 1].contains("Info - Test: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 2].contains("Warn - Test: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 3].contains("Error - Test: message #\($0.offset)"))
            XCTAssertTrue(archivedLines[$0.element + 4].contains("Critical - Test: message #\($0.offset)"))
        }
    }
    
    func testSizeBasedArchive() {
        XCTAssertFalse(target.shouldArchive)
        let maxFileSize: UInt64 = 5 * 1024
        targetConfig = FileTargetConfig(maxFileSizeInBytes: maxFileSize, style: .verbose)
        target = FileTarget(targetConfig)
        let lineCount = 100
        let writeExpectaiton = XCTestExpectation(description: "Writing \(lineCount) log lines")
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
        }
        target.dispatchQueue.async {
            writeExpectaiton.fulfill()
        }
        wait(for: [writeExpectaiton], timeout: 10.0)
        
        let archiveExpecation = XCTestExpectation(description: "Async size based archive")
        XCTAssertTrue(target.shouldArchive)
        target.dispatchQueue.async {
            self.target.archiveIfNeeded() {
                archiveExpecation.fulfill()
            }
        }
        wait(for: [archiveExpecation], timeout: 10.0)
        XCTAssertEqual(0, target.logFileSizeInBytes)
        let archivedFileCount = try! target.fileManager.contentsOfDirectory(atPath: target.archiveUrl.path).count
        XCTAssertEqual(1, archivedFileCount)
    }
}

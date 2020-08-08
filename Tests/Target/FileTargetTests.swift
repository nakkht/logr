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
    
    override func tearDown() {
        if let target = self.target {
            try! target.fileManager.removeItem(at: target.fullLogFileUrl)
            try! target.fileManager.removeItem(at: target.archiveUrl)
        }
        target = nil
        targetConfig = nil
    }
    
    func testDefaultSetup() {
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
        XCTAssertEqual("y-MM-dd HH:mm:ss.SSS", targetConfig.dateTimeFormat)
        XCTAssertEqual(Style.minimal, targetConfig.style)
        XCTAssertEqual(.debug, targetConfig.level)
        XCTAssertEqual(1, targetConfig.maxArchivedFilesCount)
        XCTAssertNil(targetConfig.dispatchQueue)
        XCTAssertNil(targetConfig.header)
    }
    
    func testConfig() {
        let size = UInt64(100 * 1024 * 1024)
        let fileExtension = "longextension"
        let fileName = "long-file-name"
        let archiveFrequence = TimeSpan.week
        let dateFormat = "y-MM-dd"
        let header = """
        ========= SYS INFO ==========
        =============================
        """
        let dispatchQueue = DispatchQueue(label: "test.queue")
        targetConfig = FileTargetConfig(fileName: fileName, fileExtension: fileExtension, maxArchivedFilesCount: 100, archiveFrequency: archiveFrequence,
                                        maxFileSizeInBytes: size, dateTimeFormat: dateFormat, level: .critical, style: .verbose, dispatchQueue: dispatchQueue,
                                        header: header)
        
        XCTAssertEqual(fileExtension, targetConfig.fileExtension)
        XCTAssertEqual(fileName, targetConfig.fileName)
        XCTAssertEqual(size, targetConfig.maxFileSizeInBytes)
        XCTAssertEqual(.verbose, targetConfig.style)
        XCTAssertEqual(.critical, targetConfig.level)
        XCTAssertEqual("\(fileName).\(fileExtension)", targetConfig.fullFileName)
        XCTAssertEqual(100, targetConfig.maxArchivedFilesCount)
        XCTAssertEqual("\(fileName).0.\(fileExtension)", targetConfig.archiveFileName)
        XCTAssertEqual(archiveFrequence, targetConfig.archiveFrequency)
        XCTAssertEqual(header, targetConfig.header)
        XCTAssertEqual(dispatchQueue, targetConfig.dispatchQueue)
        XCTAssertEqual(dispatchQueue.label, targetConfig.dispatchQueue!.label)
        XCTAssertEqual(dateFormat, targetConfig.dateTimeFormat)
    }
    
    func testManualArchive() {
        targetConfig = FileTargetConfig()
        target = FileTarget(targetConfig)
        let lineCount = 100
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta))
        }
        let expectation = XCTestExpectation(description: "Writing \(lineCount) log lines")
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
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta))
        }
        let expectation = XCTestExpectation(description: "Writing \(lineCount) log lines using serial queue")
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
        let maxFileSize: UInt64 = 5 * 1024
        targetConfig = FileTargetConfig(maxFileSizeInBytes: maxFileSize, style: .verbose)
        target = FileTarget(targetConfig)
        let lineCount = 100
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
        }
        let expectation = XCTestExpectation(description: "Writing \(lineCount) log lines")
        target.dispatchQueue.async {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60.0)
        
        let archiveExpecation = XCTestExpectation(description: "Async size based archive")
        XCTAssertTrue(target.shouldArchive)
        target.dispatchQueue.async {
            self.target.archiveIfNeeded() {
                archiveExpecation.fulfill()
            }
        }
        wait(for: [archiveExpecation], timeout: 20.0)
        XCTAssertEqual(0, target.logFileSizeInBytes)
        let archivedFileCount = try! target.fileManager.contentsOfDirectory(atPath: target.archiveUrl.path).count
        XCTAssertEqual(1, archivedFileCount)
    }
    
    func testLogFileHeader() {
        let header = """
        ========= SYS INFO ==========
        App Version : 1.2.3
        =============================
        """
        targetConfig = FileTargetConfig(header: header)
        target = FileTarget(targetConfig)
        
        XCTAssertFalse(target.shouldArchive)
        let expectation = XCTestExpectation(description: "Archive log header")
        target.archive {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        let archivedFileUrl = target.archiveUrl.appendingPathComponent(self.targetConfig.archiveFileName)
        let archivedLines = try! String(contentsOf: archivedFileUrl, encoding: .utf8)
        XCTAssertEqual(header, archivedLines)
    }
    
    func testInfoMinimumLogLevel() {
        targetConfig = FileTargetConfig(level: .info)
        target = FileTarget(targetConfig)
        let lineCount = 100
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta))
        }
        let expectation = XCTestExpectation(description: "Writing \(lineCount) log lines")
        target.archive {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
        
        let archivedFileUrl = target.archiveUrl.appendingPathComponent(self.targetConfig.archiveFileName)
        let logContent = try! String(contentsOf: archivedFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(lineCount * 4, logContent.count)
        stride(from: 0, to: logContent.count, by: 4).enumerated().forEach {
            XCTAssertTrue(logContent[$0.element].contains("Info - Test: message #\($0.offset)"))
            XCTAssertTrue(logContent[$0.element + 1].contains("Warn - Test: message #\($0.offset)"))
            XCTAssertTrue(logContent[$0.element + 2].contains("Error - Test: message #\($0.offset)"))
            XCTAssertTrue(logContent[$0.element + 3].contains("Critical - Test: message #\($0.offset)"))
        }
    }
    
    func testWarnMinimumLogLevel() {
        targetConfig = FileTargetConfig(level: .warn)
        target = FileTarget(targetConfig)
        let lineCount = 100
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta))
        }
        let expectation = XCTestExpectation(description: "Writing \(lineCount) log lines")
        target.archive {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
        
        let archivedFileUrl = target.archiveUrl.appendingPathComponent(self.targetConfig.archiveFileName)
        let logContent = try! String(contentsOf: archivedFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(lineCount * 3, logContent.count)
        stride(from: 0, to: logContent.count, by: 3).enumerated().forEach {
            XCTAssertTrue(logContent[$0.element].contains("Warn - Test: message #\($0.offset)"))
            XCTAssertTrue(logContent[$0.element + 1].contains("Error - Test: message #\($0.offset)"))
            XCTAssertTrue(logContent[$0.element + 2].contains("Critical - Test: message #\($0.offset)"))
        }
    }
    
    func testErrorMinimumLogLevel() {
        targetConfig = FileTargetConfig(level: .error)
        target = FileTarget(targetConfig)
        let lineCount = 100
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta))
        }
        let expectation = XCTestExpectation(description: "Writing \(lineCount) log lines")
        target.archive {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
        
        let archivedFileUrl = target.archiveUrl.appendingPathComponent(self.targetConfig.archiveFileName)
        let logContent = try! String(contentsOf: archivedFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(lineCount * 2, logContent.count)
        stride(from: 0, to: logContent.count, by: 2).enumerated().forEach {
            XCTAssertTrue(logContent[$0.element].contains("Error - Test: message #\($0.offset)"))
            XCTAssertTrue(logContent[$0.element + 1].contains("Critical - Test: message #\($0.offset)"))
        }
    }
    
    func testCriticalMinimumLogLevel() {
        targetConfig = FileTargetConfig(level: .critical)
        target = FileTarget(targetConfig)
        let lineCount = 100
        let meta = MetaInfo(file: #file, function: #function, line: #line)
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta))
        }
        let expectation = XCTestExpectation(description: "Writing \(lineCount) log lines")
        target.archive {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 20.0)
        
        let archivedFileUrl = target.archiveUrl.appendingPathComponent(self.targetConfig.archiveFileName)
        let logContent = try! String(contentsOf: archivedFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(lineCount, logContent.count)
        stride(from: 0, to: logContent.count, by: 1).enumerated().forEach {
            XCTAssertTrue(logContent[$0.element].contains("Critical - Test: message #\($0.offset)"))
        }
    }
}

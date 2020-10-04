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

class FileTargetTests: XCTestCase {
    
    var target: FileTarget!
    var targetConfig: FileTargetConfig!
    
    override func tearDown() {
        if let target = self.target {
            try? target.fileManager.removeItem(at: self.target.baseLogDirectory)
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
        XCTAssertEqual(DispatchQueue.io, target.dispatchQueue)
        
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
        XCTAssertEqual(2, targetConfig.maxArchivedFilesCount)
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
        targetConfig = FileTargetConfig(fileName: fileName, fileExtension: fileExtension, maxArchivedFilesCount: 100, archiveFrequency: archiveFrequence,
                                        maxFileSizeInBytes: size, dateTimeFormat: dateFormat, level: .critical, style: .verbose,
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
        XCTAssertEqual(dateFormat, targetConfig.dateTimeFormat)
    }
    
    func testManualArchive() {
        targetConfig = FileTargetConfig()
        target = FileTarget(targetConfig)
        let lineCount = 10
        let meta = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta))
        }
        target.sync()
        let expectation = XCTestExpectation(description: "Writing \(lineCount) log lines")
        target.forceArchive {
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
        targetConfig = FileTargetConfig()
        target = FileTarget(targetConfig, dispatchQueue: dispatchQueue)
        let lineCount = 10
        let meta = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .info, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .warn, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .error, tag: "Test", text: "message #\($0)", meta: meta))
            target.send(Message(level: .critical, tag: "Test", text: "message #\($0)", meta: meta))
        }
        target.sync()
        let logContent = try! String(contentsOf: target.logFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(lineCount * 5, logContent.count)
        stride(from: 0, to: lineCount, by: 5).enumerated().forEach {
            XCTAssertTrue(logContent[$0.element].contains("Debug - Test: message #\($0.offset)"))
            XCTAssertTrue(logContent[$0.element + 1].contains("Info - Test: message #\($0.offset)"))
            XCTAssertTrue(logContent[$0.element + 2].contains("Warn - Test: message #\($0.offset)"))
            XCTAssertTrue(logContent[$0.element + 3].contains("Error - Test: message #\($0.offset)"))
            XCTAssertTrue(logContent[$0.element + 4].contains("Critical - Test: message #\($0.offset)"))
        }
    }
    
    func testSizeBasedArchive() {
        let maxFileSize: UInt64 = 1024
        targetConfig = FileTargetConfig(maxFileSizeInBytes: maxFileSize, style: .verbose)
        target = FileTarget(targetConfig)
        let lineCount = 20
        let meta = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
        }
        target.sync()
        
        let archivedFileCount = try! target.fileManager.contentsOfDirectory(atPath: target.archiveUrl.path).count
        XCTAssertEqual(1, archivedFileCount)
    }
    
    func testMultipleSizeBasedArchives() {
        let maxFileSize: UInt64 = 1024
        targetConfig = FileTargetConfig(maxFileSizeInBytes: maxFileSize, style: .verbose)
        target = FileTarget(targetConfig)
        
        let lineCount = 40
        let meta = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
        }
        target.sync()
        
        let archivedFileCount = try! target.fileManager.contentsOfDirectory(atPath: target.archiveUrl.path).count
        XCTAssertEqual(2, archivedFileCount)
    }
    
    func testMaxArchivedFilesCount() {
        let maxFileSize: UInt64 = 1024
        let maxArchivedFilesCount: UInt16 = 7
        targetConfig = FileTargetConfig(maxArchivedFilesCount: maxArchivedFilesCount, maxFileSizeInBytes: maxFileSize, style: .verbose)
        target = FileTarget(targetConfig)
        
        let lineCount = 20 * 10
        let meta = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        (0..<lineCount).forEach {
            target.send(Message(level: .debug, tag: "Test", text: "message #\($0)", meta: meta))
        }
        target.sync()
        
        let archivedFileCount = try! target.fileManager.contentsOfDirectory(atPath: target.archiveUrl.path).count
        XCTAssertEqual(7, archivedFileCount)
    }
    
    func testLogFileHeader() {
        let header = """
        ========= SYS INFO ==========
        App Version : 1.2.3
        =============================
        """
        targetConfig = FileTargetConfig(header: header)
        target = FileTarget(targetConfig)
        XCTAssertTrue(target.fileManager.fileExists(atPath: target.logFileUrl.path))
        
        target.sync()
        
        let logContent = try! String(contentsOf: target.logFileUrl, encoding: .utf8)
        XCTAssertEqual(header, logContent)
    }
    
    func testInfoMinimumLogLevel() {
        targetConfig = FileTargetConfig(level: .info)
        target = FileTarget(targetConfig)
        let meta = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        target.send(Message(level: .debug, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .info, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .warn, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .error, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .critical, tag: "Test", text: "message", meta: meta))
        
        target.sync()
        
        let logContent = try! String(contentsOf: target.logFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(4, logContent.count)
        XCTAssertTrue(logContent[0].contains("Info - Test: message"))
        XCTAssertTrue(logContent[1].contains("Warn - Test: message"))
        XCTAssertTrue(logContent[2].contains("Error - Test: message"))
        XCTAssertTrue(logContent[3].contains("Critical - Test: message"))
    }
    
    func testWarnMinimumLogLevel() {
        targetConfig = FileTargetConfig(level: .warn)
        target = FileTarget(targetConfig)
        let meta = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        target.send(Message(level: .debug, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .info, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .warn, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .error, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .critical, tag: "Test", text: "message", meta: meta))
        
        target.sync()
        
        let logContent = try! String(contentsOf: target.logFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(3, logContent.count)
        XCTAssertTrue(logContent[0].contains("Warn - Test: message"))
        XCTAssertTrue(logContent[1].contains("Error - Test: message"))
        XCTAssertTrue(logContent[2].contains("Critical - Test: message"))
    }
    
    func testErrorMinimumLogLevel() {
        targetConfig = FileTargetConfig(level: .error)
        target = FileTarget(targetConfig)
        let meta = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        target.send(Message(level: .debug, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .info, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .warn, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .error, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .critical, tag: "Test", text: "message", meta: meta))
        
        target.sync()
        
        let logContent = try! String(contentsOf: target.logFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(2, logContent.count)
        XCTAssertTrue(logContent[0].contains("Error - Test: message"))
        XCTAssertTrue(logContent[1].contains("Critical - Test: message"))
    }
    
    func testCriticalMinimumLogLevel() {
        targetConfig = FileTargetConfig(level: .critical)
        target = FileTarget(targetConfig)
        let meta = MetaInfo(file: #file, function: #function, line: #line, timeStamp: Date())
        target.send(Message(level: .debug, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .info, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .warn, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .error, tag: "Test", text: "message", meta: meta))
        target.send(Message(level: .critical, tag: "Test", text: "message", meta: meta))
        
        target.sync()
        
        let logContent = try! String(contentsOf: target.logFileUrl, encoding: .utf8).components(separatedBy: .newlines).dropLast()
        XCTAssertEqual(1, logContent.count)
        XCTAssertTrue(logContent[0].contains("Critical - Test: message"))
    }
}

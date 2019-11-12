//
//  FileTargetConfigTests.swift
//  LogrTests
//
//  Created by Paulius Gudonis on 11/09/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import XCTest
@testable import Logr

class FileTargetConfigTests: XCTestCase {
    
    var fileTargetConfig: FileTargetConfig!
    
    override func setUp() {
        fileTargetConfig = FileTargetConfig()
        
        XCTAssertEqual(1, fileTargetConfig.maxArchivedFilesCount)
    }
    
    override func tearDown() {
        fileTargetConfig = nil
    }
    
    func testDefaultValues() {
        fileTargetConfig = FileTargetConfig()
        
        XCTAssertEqual("log", fileTargetConfig.fileExtension)
        XCTAssertEqual("file", fileTargetConfig.fileName)
        XCTAssertEqual(TimeSpan.day, fileTargetConfig.archiveFrequency)
        XCTAssertEqual(FileTargetConfig.defaultMaxFileSizeInBytes, fileTargetConfig.maxFileSizeInBytes)
        XCTAssertEqual("file.log", fileTargetConfig.fullFileName)
        XCTAssertEqual("file.0.log", fileTargetConfig.archiveFileName)
        XCTAssertEqual(Style.minimal, fileTargetConfig.style)
        XCTAssertEqual(LogLevel.allCases, fileTargetConfig.levels)
        XCTAssertEqual(1, fileTargetConfig.maxArchivedFilesCount)
    }
    
    func testSetFileExtension() {
        fileTargetConfig = FileTargetConfig(fileExtension: "")
        XCTAssertEqual("", fileTargetConfig.fileExtension)
        
        fileTargetConfig = FileTargetConfig(fileExtension: "longextension")
        XCTAssertEqual("longextension", fileTargetConfig.fileExtension)
    }
    
    func testSetFileName() {
        fileTargetConfig = FileTargetConfig(fileName: "")
        XCTAssertEqual("", fileTargetConfig.fileName)
        
        let longFileName = "long-file-name"
        fileTargetConfig = FileTargetConfig(fileName: longFileName)
        XCTAssertEqual(longFileName, fileTargetConfig.fileName)
    }
    
    func testSetArchiveFrequency() {
        TimeSpan.allCases.forEach {
            fileTargetConfig = FileTargetConfig(archiveFrequency: $0)
            XCTAssertEqual($0, fileTargetConfig.archiveFrequency)
        }
    }
    
    func testSetFileSizes() {
        let size = UInt64(100 * 1024 * 1024)
        fileTargetConfig = FileTargetConfig(maxFileSizeInBytes: size)
        XCTAssertEqual(size, fileTargetConfig.maxFileSizeInBytes)
    }
    
    func testSetStyle() {
        fileTargetConfig = FileTargetConfig(style: .verbose)
        XCTAssertEqual(.verbose, fileTargetConfig.style)
    }
    
    func testSetLevels() {
        fileTargetConfig = FileTargetConfig(levels: [.debug])
        XCTAssertEqual([.debug], fileTargetConfig.levels)
    }
    
    func testFullFileName() {
        fileTargetConfig = FileTargetConfig(fileName: "filename", fileExtension: "txt")
        XCTAssertEqual("filename.txt", fileTargetConfig.fullFileName)
    }
    
    func testSetMaxArchivedFileCount() {
        fileTargetConfig = FileTargetConfig(maxArchivedFilesCount: 100)
        XCTAssertEqual(100, fileTargetConfig.maxArchivedFilesCount)
    }
    
    func testFullArchiveFileName() {
        fileTargetConfig = FileTargetConfig(fileName: "filename", fileExtension: "txt")
        XCTAssertEqual("filename.0.txt", fileTargetConfig.archiveFileName)
    }
}

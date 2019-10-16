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
        XCTAssertEqual(fileTargetConfig.maxFileSizeInBytes, fileTargetConfig.maxFileSizeInBytes)
        XCTAssertEqual("file.log", fileTargetConfig.fullFileName)
        XCTAssertEqual("archive/file.0.log", fileTargetConfig.fullArchiveFileName)
    }
    
    func testFileExtension() {
        fileTargetConfig = FileTargetConfig(fileExtension: "")
        XCTAssertEqual("", fileTargetConfig.fileExtension)
        
        fileTargetConfig = FileTargetConfig(fileExtension: "longextension")
        XCTAssertEqual("longextension", fileTargetConfig.fileExtension)
    }
    
    func testFileName() {
        fileTargetConfig = FileTargetConfig(fileName: "")
        XCTAssertEqual("", fileTargetConfig.fileName)
        
        let longFileName = "long-file-name"
        fileTargetConfig = FileTargetConfig(fileName: longFileName)
        XCTAssertEqual(longFileName, fileTargetConfig.fileName)
    }
    
    func testTimeSpan() {
        TimeSpan.allCases.forEach {
            fileTargetConfig = FileTargetConfig(archiveFrequency: $0)
            XCTAssertEqual($0, fileTargetConfig.archiveFrequency)
        }
    }
    
    func testFileSizes() {
        let size = UInt(100 * 1024 * 1024)
        fileTargetConfig = FileTargetConfig(maxFileSizeInBytes: size)
        XCTAssertEqual(size, fileTargetConfig.maxFileSizeInBytes)
    }
    
    func testFullFileName() {
        fileTargetConfig.fileName = "filename"
        fileTargetConfig.fileExtension = "txt"
        XCTAssertEqual("filename.txt", fileTargetConfig.fullFileName)
    }
    
    func testFullArchiveFileName() {
        fileTargetConfig.fileName = "filename"
        fileTargetConfig.fileExtension = "txt"
        XCTAssertEqual("archive/filename.0.txt", fileTargetConfig.fullArchiveFileName)
    }
}

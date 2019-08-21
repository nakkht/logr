//
//  FileTargetConfig.swift
//  Logr
//
//  Created by Paulius Gudonis on 27/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public struct FileTargetConfig {
    
    public static let defaultMaxFileSizeInBytes: UInt = 20 * 1024 * 1024
    
    public let fileExtension: String
    public let fileName: String
    
    public let maxArchivedFilesCount = 1
    public let archiveFrequency: TimeSpan
    public let maxFileSizeInBytes: UInt
    
    init(fileName: String = "file", fileExtension: String = "log", archiveFrequency: TimeSpan = .day, maxFileSizeInBytes: UInt? = nil) {
        self.fileExtension = fileExtension
        self.fileName = fileName
        self.archiveFrequency = archiveFrequency
        self.maxFileSizeInBytes = maxFileSizeInBytes ?? FileTargetConfig.defaultMaxFileSizeInBytes
    }
    
    var fullFileName: String {
        return "\(fileName).\(fileExtension)"
    }
    
    var fullArchiveFileName: String {
        return "archive/\(fileName).0.\(fileExtension)"
    }
}

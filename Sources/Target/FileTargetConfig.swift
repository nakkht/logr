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
    public let levels: [LogLevel]
    
    public init(fileName: String? = nil, fileExtension: String? = nil, archiveFrequency: TimeSpan? = nil,
                maxFileSizeInBytes: UInt? = nil, levels: [LogLevel]? = nil) {
        self.fileExtension = fileExtension ?? "log"
        self.fileName = fileName ?? "file"
        self.archiveFrequency = archiveFrequency ?? .day
        self.maxFileSizeInBytes = maxFileSizeInBytes ?? FileTargetConfig.defaultMaxFileSizeInBytes
        self.levels = levels ?? LogLevel.allCases
    }
    
    var fullFileName: String {
        return "\(fileName).\(fileExtension)"
    }
    
    var fullArchiveFileName: String {
        return "archive/\(fileName).0.\(fileExtension)"
    }
}

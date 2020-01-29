//
//  FileTargetConfig.swift
//  Logr
//
//  Created by Paulius Gudonis on 27/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public struct FileTargetConfig {
    
    public static let defaultMaxFileSizeInBytes: UInt64 = 20 * 1024 * 1024
    
    /// Log file extension. Defaults to `log`.
    public let fileExtension: String
    
    /// Log file name. Defaults to `file`.
    public let fileName: String
    
    /// Maximum number of archived files to keep. Defaults to 1.
    public let maxArchivedFilesCount: UInt16
    
    /// Determines minimum time until log file should be archived.
    public let archiveFrequency: TimeSpan
    
    /// Determines minimum file size until log file should be archived.
    public let maxFileSizeInBytes: UInt64
    
    /// Log levels that should allowed for the target.
    public let levels: [LogLevel]
    
    /// Determines logging style used by the target.
    public let style: Style
    
    /// Optional dispatch queue assigned during initialization.
    public let dispatchQueue: DispatchQueue?
    
    public init(fileName: String? = nil, fileExtension: String? = nil, maxArchivedFilesCount: UInt16? = nil,
                archiveFrequency: TimeSpan? = nil, maxFileSizeInBytes: UInt64? = nil,
                levels: [LogLevel]? = nil, style: Style? = nil, dispatchQueue: DispatchQueue? = nil) {
        self.fileExtension = fileExtension ?? "log"
        self.fileName = fileName ?? "file"
        self.maxArchivedFilesCount = maxArchivedFilesCount ?? 1
        self.archiveFrequency = archiveFrequency ?? .day
        self.maxFileSizeInBytes = maxFileSizeInBytes ?? FileTargetConfig.defaultMaxFileSizeInBytes
        self.levels = levels ?? LogLevel.allCases
        self.style = style ?? .minimal
        self.dispatchQueue = dispatchQueue
    }
    
    public var fullFileName: String {
        return "\(fileName).\(fileExtension)"
    }
    
    public var archiveFileName: String {
        return "\(fileName).0.\(fileExtension)"
    }
}

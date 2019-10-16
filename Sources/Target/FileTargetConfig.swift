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
    
    public var fileExtension: String = "log"
    public var fileName: String = "file"
    
    public var maxArchivedFilesCount = 1
    public var archiveFrequency: TimeSpan = .day
    public var maxFileSizeInBytes: UInt = FileTargetConfig.defaultMaxFileSizeInBytes
    public var levels: [LogLevel] = LogLevel.allCases
    public var style: Style = .minimal
    
    var fullFileName: String {
        return "\(fileName).\(fileExtension)"
    }
    
    var fullArchiveFileName: String {
        return "archive/\(fileName).0.\(fileExtension)"
    }
}

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

import Foundation

public struct FileTargetConfig {
    
    public static let defaultMaxFileSizeInBytes: UInt64 = 20 * 1024 * 1024
    public static let defaultDateTimeFormat = "y-MM-dd H:m:ss.SSS"
    
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
    
    /// Format to be used for log line timestamps
    public let dateTimeFormat: String
    
    /// Optional dispatch queue assigned during initialization.
    public let dispatchQueue: DispatchQueue?
    
    public init(fileName: String? = nil, fileExtension: String? = nil, maxArchivedFilesCount: UInt16? = nil,
                archiveFrequency: TimeSpan? = nil, maxFileSizeInBytes: UInt64? = nil, dateTimeFormat: String? = nil,
                levels: [LogLevel]? = nil, style: Style? = nil, dispatchQueue: DispatchQueue? = nil) {
        self.fileExtension = fileExtension ?? "log"
        self.fileName = fileName ?? "file"
        self.maxArchivedFilesCount = maxArchivedFilesCount ?? 1
        self.archiveFrequency = archiveFrequency ?? .day
        self.maxFileSizeInBytes = maxFileSizeInBytes ?? FileTargetConfig.defaultMaxFileSizeInBytes
        self.dateTimeFormat = dateTimeFormat ?? FileTargetConfig.defaultDateTimeFormat
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

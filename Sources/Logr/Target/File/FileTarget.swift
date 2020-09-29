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

import Foundation

/// Target class for logging to a file.
open class FileTarget: Target {
    
    lazy var fileManager = FileManager.default
    var dispatchQueue = DispatchQueue(label: "com.neqsoft.file_target", qos: .background)
    
    /// Base directory URL for logged files.
    public lazy var baseLogDirectory = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    
    /// URL of main log file.
    public lazy var fullLogFileUrl = baseLogDirectory.appendingPathComponent(self.config.fullFileName)
    
    /// URL of  archive folder.
    public lazy var archiveUrl = baseLogDirectory.appendingPathComponent("archive", isDirectory: true)
    
    /// Config struct assigned during initialization
    public let config: FileTargetConfig
    
    /// File handle of a current log file being written to.
    public var fileHandle: FileHandle?
    
    let dateFormatter: DateFormatter
    
    /**
     Initializes FileTarget instance with provided FileTargetConfig struct. Prepares file for receiving and persisting log messages.
     
     - Parameters:
     - config: struct encapsulating logging preferences. Defaults to struct instance with defaults values.
     */
    public init(_ config: FileTargetConfig? = nil) {
        self.config = config ?? FileTargetConfig()
        if let configDispatchQueue = config?.dispatchQueue {
            self.dispatchQueue = configDispatchQueue
        }
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = self.config.dateTimeFormat
        initFile()
        try? fileManager.createDirectory(at: self.archiveUrl, withIntermediateDirectories: true, attributes: nil)
    }
    
    open func send(_ message: Message) {
        guard message.level.rawValue >= self.config.level.rawValue else { return }
        self.write(self.formatted(message))
    }
    
    open func formatted(_ message: Message) -> String {
        let metaText = self.config.style == .verbose ? "\(message.meta.text) " : ""
        return "\(dateString) \(metaText)\(message.level.description) - \(message.tag): \(message.text)\n"
    }
    
    var dateString: String {
        return self.dateFormatter.string(from: Date())
    }
    
    func write(_ log: String) {
        guard !log.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        dispatchQueue.async {
            guard let data = log.data(using: .utf8), data.count > 0 else { return }
            self.fileHandle?.seekToEndOfFile()
            self.fileHandle?.write(data)
            self.fileHandle?.synchronizeFile()
        }
    }
    
    /// Forces archive process of the current log file regardless of the preconditions set in config files. Non-blocking. Thread-safe.
    /// - Parameter completionHandler: the block to execute when archiving as completed
    public func archive(_ completionHandler: (() -> Void)? = nil) {
        dispatchQueue.async {
            self.shiftArchivedFiles()
            self.closeFile()
            self.moveFileToArchive()
            self.initFile()
            self.deleteObsoletFiles(at: self.archiveUrl)
            completionHandler?()
        }
    }
    
    func initFile() {
        let didCreateNewFile = self.createFileIfNeeded(fullLogFileUrl)
        self.fileHandle = FileHandle(forWritingAtPath: fullLogFileUrl.path)
        if didCreateNewFile, let header = config.header { self.write(header) }
    }
    
    @discardableResult
    func createFileIfNeeded(_ url: URL) -> Bool {
        guard !self.doesLogFileExists else { return false }
        try? self.fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        self.fileManager.createFile(atPath: url.path,
                                    contents: nil,
                                    attributes: [.creationDate: Date()])
        return true
    }
    
    func closeFile() {
        self.fileHandle?.synchronizeFile()
        self.fileHandle?.closeFile()
    }
    
    func moveFileToArchive() {
        let archiveFileUrl = archiveUrl.appendingPathComponent(self.config.archiveFileName)
        try? self.fileManager.moveItem(atPath: fullLogFileUrl.path, toPath: archiveFileUrl.path)
    }
    
    func deleteObsoletFiles(at url: URL) {
        guard let contents = try? fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil) else { return }
        let filesForDeletion = contents.sorted {
            $0.path.compare($1.path, options: .numeric) == .orderedAscending
        }.dropFirst(Int(self.config.maxArchivedFilesCount))
        filesForDeletion.forEach {
            try? self.fileManager.removeItem(at: $0)
        }
    }
    
    func shiftArchivedFiles() {
        guard let contents = try? fileManager.contentsOfDirectory(at: self.archiveUrl, includingPropertiesForKeys: nil) else { return }
        let archivedFiles = contents.sorted {
            $0.path.compare($1.path, options: .numeric) == .orderedAscending
        }
        archivedFiles.enumerated().reversed().forEach { (offset: Int, url: URL) in
            let newFileUrl = archiveUrl.appendingPathComponent("\(self.config.fileName).\(offset + 1).\(self.config.fileExtension)")
            try? self.fileManager.moveItem(at: url, to: newFileUrl)
        }
    }
    
    func archiveIfNeeded(_ completionHandler: (() -> Void)? = nil) {
        guard self.shouldArchive else {
            completionHandler?()
            return
        }
        self.archive(completionHandler)
    }
    
    var shouldArchive: Bool {
        guard let logFileAge = self.logFileAge else { return shouldArchiveBasedOnSize }
        return logFileAge.rawValue >= config.archiveFrequency.rawValue || shouldArchiveBasedOnSize
    }
    
    var shouldArchiveBasedOnSize: Bool {
        return logFileSizeInBytes > config.maxFileSizeInBytes
    }
    
    var logFileAge: TimeSpan? {
        guard let creationDate = try? fileManager.attributesOfItem(atPath: fullLogFileUrl.path)[.creationDate] as? Date,
            let modificationDate = try? fileManager.attributesOfItem(atPath: fullLogFileUrl.path)[.modificationDate] as? Date else {
                return nil
        }
        let components = Calendar.current.dateComponents([.minute, .hour, .day, .weekOfYear, .month], from: creationDate, to: modificationDate)
        switch components {
        case _ where components.month ?? 0 >= 1: return .month
        case _ where components.weekOfYear ?? 0 >= 1: return .week
        case _ where components.day ?? 0 >= 1: return .day
        case _ where components.hour ?? 0 >= 1: return .hour
        case _ where components.minute ?? 0 >= 1: return .minute
        default: return nil
        }
    }
    
    var logFileSizeInBytes: UInt64 {
        let size = try? fileManager.attributesOfItem(atPath: fullLogFileUrl.path)[.size] as? UInt64
        return size ?? 0
    }
    
    var doesLogFileExists: Bool {
        return fileManager.fileExists(atPath: self.fullLogFileUrl.path)
    }
}

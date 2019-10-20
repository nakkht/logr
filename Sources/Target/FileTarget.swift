//
//  FileTarget.swift
//  Logr
//
//  Created by Paulius Gudonis on 22/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public class FileTarget: Target {
    
    public lazy var fileManager = FileManager.default
    public lazy var baseLogDirectory = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    public lazy var fullLogFileUrl = baseLogDirectory.appendingPathComponent(self.config.fullFileName)
    public lazy var fullArchiveFileUrl = baseLogDirectory.appendingPathComponent(self.config.fullArchiveFileName)
    public let config: FileTargetConfig
    public var fileHandle: FileHandle?
    
    let dispatchQueue = DispatchQueue(label: "com.neqsoft.file_target", qos: .background)
    
    public init(_ config: FileTargetConfig? = nil) {
        self.config = config ?? FileTargetConfig()
        initFile()
    }
    
    public func send(_ message: Message) {
        guard self.config.levels.contains(message.level) else { return }
        let metaText = self.config.style == .verbose ? "\(message.metaText) " : ""
        self.write("\(metaText)\(message.level.title): \(message.text)\n")
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
    
    public func archive() {
        dispatchQueue.async {
            self.renameArchivedFiles()
            self.closeFile()
            self.moveFile()
            self.initFile()
            self.deleteOldFiles()
        }
    }
    
    func initFile() {
        let fullFilePath = self.baseLogDirectory.appendingPathComponent(self.config.fullFileName)
        self.createFileIfNeeded(fullLogFileUrl)
        self.fileHandle = FileHandle(forWritingAtPath: fullFilePath.path)
    }
    
    func createFileIfNeeded(_ url: URL) {
        guard !self.doesLogFileExists else { return }
        try? self.fileManager.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        self.fileManager.createFile(atPath: url.path,
                                    contents: nil,
                                    attributes: [.creationDate: Date()])
    }
    
    func closeFile() {
        self.fileHandle?.synchronizeFile()
        self.fileHandle?.closeFile()
    }
    
    func moveFile() {
        try? self.fileManager.moveItem(atPath: fullLogFileUrl.path, toPath: fullArchiveFileUrl.path)
    }
    
    func deleteOldFiles() {
        guard let contents = try? fileManager.contentsOfDirectory(at: baseLogDirectory, includingPropertiesForKeys: nil) else { return }
        let filesForDeletion = contents.sorted {
            $0.path.compare($1.path, options: .numeric) == .orderedAscending
        }.dropFirst(self.config.maxArchivedFilesCount)
        guard filesForDeletion.count > 0 else { return }
        filesForDeletion.forEach {
            try? self.fileManager.removeItem(at: $0)
        }
    }
    
    func renameArchivedFiles() {
        guard let contents = try? fileManager.contentsOfDirectory(at: baseLogDirectory, includingPropertiesForKeys: nil) else { return }
        let archivedFiles = contents.sorted {
            $0.path.compare($1.path, options: .numeric) == .orderedAscending
        }
        archivedFiles.enumerated().reversed().forEach { (offset: Int, url: URL) in
            let newFileUrl = baseLogDirectory.appendingPathComponent("archive/\(self.config.fileName).\(offset + 1).\(self.config.fileExtension)")
            try? self.fileManager.moveItem(at: url, to: newFileUrl)
        }
    }
    
    func archiveIfNeeded() {
        guard self.shouldArchive else { return }
        self.archive()
    }
    
    var shouldArchive: Bool {
        guard let logFileAge = self.logFileAge else {
            return shouldArchiveBasedOnSize
        }
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

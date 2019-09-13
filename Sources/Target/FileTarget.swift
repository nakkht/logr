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
    
    init(_ config: FileTargetConfig? = nil) {
        self.config = config ?? FileTargetConfig()
        initFile()
    }
    
    public func send(_ level: LogLevel, _ message: String, _ metaInfo: MetaInfo) {
        guard self.config.levels.contains(level) else { return }
        self.write("\(metaInfo.file) \(metaInfo.function) \(metaInfo.line) \(level.title): \(message)\n")
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
    
    func initFile() {
        let fullFilePath = baseLogDirectory.appendingPathComponent(self.config.fullFileName).absoluteString
        FileManager.default.createFile(atPath: fullFilePath,
                                       contents: nil,
                                       attributes: [.creationDate: Date()])
        self.fileHandle = FileHandle(forWritingAtPath: fullFilePath)
    }
    
    func closeFile() {
        self.fileHandle?.synchronizeFile()
        self.fileHandle?.closeFile()
    }
    
    func moveFile() {
        try? self.fileManager.moveItem(atPath: fullLogFileUrl.absoluteString, toPath: fullArchiveFileUrl.absoluteString)
    }
    
    func deleteOldFiles() {
        guard let contents = try? fileManager.contentsOfDirectory(at: baseLogDirectory, includingPropertiesForKeys: nil) else { return }
        let filesForDeletion = contents.sorted {
            $0.absoluteString.compare($1.absoluteString, options: .numeric) == .orderedAscending
            }.dropFirst(self.config.maxArchivedFilesCount)
        guard filesForDeletion.count > 0 else { return }
        filesForDeletion.forEach {
            try? self.fileManager.removeItem(at: $0)
        }
    }
    
    func renameArchivedFiles() {
        guard let contents = try? fileManager.contentsOfDirectory(at: baseLogDirectory, includingPropertiesForKeys: nil) else { return }
        let archivedFiles = contents.sorted {
            $0.absoluteString.compare($1.absoluteString, options: .numeric) == .orderedAscending
        }
        archivedFiles.enumerated().reversed().forEach { (offset: Int, url: URL) in
            let newFileUrl = baseLogDirectory.appendingPathComponent("archive/\(self.config.fileName).\(offset + 1).\(self.config.fileExtension)")
            try? self.fileManager.moveItem(at: url, to: newFileUrl)
        }
    }
    
    func archive() {
        dispatchQueue.async {
            guard self.shouldArchive else { return }
            self.renameArchivedFiles()
            self.closeFile()
            self.moveFile()
            self.initFile()
            self.deleteOldFiles()
        }
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
        guard let creationDate = try? fileManager.attributesOfItem(atPath: fullLogFileUrl.absoluteString)[.creationDate] as? Date,
            let modificationDate = try? fileManager.attributesOfItem(atPath: fullLogFileUrl.absoluteString)[.modificationDate] as? Date else {
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
        guard let size = try? fileManager.attributesOfItem(atPath: fullLogFileUrl.absoluteString)[.size] as? UInt64 else {
            return 0
        }
        return size
    }
}

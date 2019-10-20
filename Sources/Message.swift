//
//  Message.swift
//  Logr
//
//  Created by Paulius Gudonis on 20/10/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//


import Foundation

public struct Message {
    
    public let level: LogLevel
    public let text: String
    public let meta: MetaInfo
    
    public var metaText: String { return meta.text}
}

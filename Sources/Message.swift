//
//  Message.swift
//  Logr
//
//  Created by Paulius Gudonis on 20/10/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

/// Immutable struct encapsulating all log message data.
public struct Message {
    
    /// Log level of the log message.
    public let level: LogLevel
    
    /// Actual provided log message.
    public let text: String
    
    /// Meta information of the log message.
    public let meta: MetaInfo
}

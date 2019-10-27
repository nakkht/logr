//
//  MetaInfo.swift
//  Logr
//
//  Created by Paulius Gudonis on 26/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

/// Immutable struct for encapsulating meta information of the log message.
public struct MetaInfo: Equatable {
    
    /// Name of the file where log call happened.
    public var file: String
    
    /// Name of the function where log call happened.
    public var function: String
    
    /// Line number of the log call.
    public var line: Int
    
    /// Property for transforming MetaInfo struct into text line.
    public var text: String {
        return "\(file) \(function) \(line)"
    }
}

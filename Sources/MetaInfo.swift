//
//  MetaInfo.swift
//  Logr
//
//  Created by Paulius Gudonis on 26/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public struct MetaInfo: Equatable {
    
    public var file: String
    public var function: String
    public var line: Int
    
    public var text: String {
        return "\(file) \(function) \(line)"
    }
}

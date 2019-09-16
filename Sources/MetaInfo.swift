//
//  MetaInfo.swift
//  Logr
//
//  Created by Paulius Gudonis on 26/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public struct MetaInfo {
    
    var file: String
    var function: String
    var line: Int
    
    var text: String {
        return "\(file) \(function) \(line)"
    }
}

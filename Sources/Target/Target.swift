//
//  File.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public protocol Target {
    
    func send(_ level: LogLevel, message: String, file: String, function: String, line: Int)
}
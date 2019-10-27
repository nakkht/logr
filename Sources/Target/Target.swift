//
//  File.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

/// Protocol required by LogrService to dispatch messages.
public protocol Target {
    
    
    /**
     Function called by LogrService on each received log message. 
     
     - Parameters:
        - message: log message including all meta information related to it
     */
    func send(_ message: Message)
}

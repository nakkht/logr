//
//  Config.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

/// Struct used to enapsulate configuration values, i.e. LogrService.
public struct Config {
    
    /// Targets assigned during initialization.
    public let targets: [Target]?
    
    /// Bool flag assigned during initialization.
    public let async: Bool
    
    /// Optional dispatch queue assigned during initialization.
    public let dispatchQueue: DispatchQueue?
    
    /**
     Initializes new immutable config struct with provided values.
     
     - Parameters:
        - async: determines whether executions passed to the targets will be synchronous or asynchronous. Default: true
        - dispatchQueue: dispatch queue onto which logging messages shall be dispatched to the targets
        - targets: array of targets to which logging messages shall be dispatched
     */
    public init(async: Bool = true, dispatchQueue: DispatchQueue? = nil, targets: [Target]? = nil) {
        self.targets = targets
        self.async = async
        self.dispatchQueue = dispatchQueue
    }
    
    /**
    Initializes new immutable config struct with provided values.
    
    - Parameters:
       - async: determines whether executions passed to the targets will be synchronous or asynchronous. Default: true
       - dispatchQueue: dispatch queue onto which logging messages shall be dispatched to the targets
       - targets: variadic array of targets to which logging messages shall be dispatched
    */
    public init(async: Bool = true, dispatchQueue: DispatchQueue? = nil, _ targets: Target...) {
        self.init(async: async, dispatchQueue: dispatchQueue, targets: targets)
    }
}

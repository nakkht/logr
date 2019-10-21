//
//  Config.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public struct Config {
    
    public let targets: [Target]?
    public let async: Bool
    public let dispatchQueue: DispatchQueue?
    
    public init(async: Bool? = nil, dispatchQueue: DispatchQueue? = nil, targets: [Target]? = nil) {
        self.targets = targets
        self.async = async ?? true
        self.dispatchQueue = dispatchQueue
    }
    
    public init(async: Bool? = nil, dispatchQueue: DispatchQueue? = nil, _ targets: Target...) {
        self.init(async: async, dispatchQueue: dispatchQueue, targets: targets)
    }
}

//
//  Config.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public struct Config {
    
    let targets: [Target]?
    let async: Bool
    let dispatchQueue: DispatchQueue?
    
    public init(async: Bool = true, dispatchQueue: DispatchQueue? = nil, targets: [Target]? = nil) {
        self.targets = targets
        self.async = async
        self.dispatchQueue = dispatchQueue
    }
    
    public init(async: Bool = true, dispatchQueue: DispatchQueue? = nil, _ targets: Target...) {
        self.init(async: async, dispatchQueue: dispatchQueue, targets: targets)
    }
}

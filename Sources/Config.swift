//
//  Config.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public class Config {
    
    let targets: [Target]?
    let async: Bool
    
    public init(async: Bool = true, targets: [Target]? = nil) {
        self.targets = targets
        self.async = async
    }
    
    public convenience init(async: Bool = true, _ targets: Target...) {
        self.init(async: async, targets: targets)
    }
}

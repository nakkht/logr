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
    
    public init(_ targets: Target...) {
        self.targets = targets
    }
}

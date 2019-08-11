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
    
    public init(_ targets: Target..., async: Bool = true) {
        self.targets = targets
        self.async = async
    }
}

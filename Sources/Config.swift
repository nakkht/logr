//
//  Config.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/07/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

public struct Config {
    
    var targets: [Target]? = nil
    var async: Bool = true
    var dispatchQueue: DispatchQueue? = nil
}

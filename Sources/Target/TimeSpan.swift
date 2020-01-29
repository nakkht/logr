//
//  TimeSpan.swift
//  Logr
//
//  Created by Paulius Gudonis on 28/08/2019.
//  Copyright © 2019 neqsoft. All rights reserved.
//

import Foundation

/// Enum containing distinct time span values used within library.
public enum TimeSpan: UInt, CaseIterable {
    
    /// Denotes time span of a minute.
    case minute
    
    /// Denotes time span of an hour.
    case hour
    
    /// Denotes time span of a day.
    case day
    
    /// Denotes time span of a week.
    case week
    
    /// Dentotes time span of a month.
    case month
}

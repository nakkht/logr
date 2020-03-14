//
// Copyright 2020 Paulius Gudonis, neqsoft
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
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

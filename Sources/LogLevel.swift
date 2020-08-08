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

/// Enum containing available distinct log levels within library.
public enum LogLevel: Int, Equatable, CustomStringConvertible {
    
    /// Denotes verbose log level
    case debug = 0
    
    /// Denotes informational log level
    case info = 1
    
    /// Denotes warning log level
    case warn = 2
    
    /// Denotes error log level
    case error = 3
    
    /// Denotes critical log level
    case critical = 4
    
    /// String representation of the log level.
    public var description: String {
        switch self {
        case .debug: return "Debug"
        case .info: return "Info"
        case .warn: return "Warn"
        case .error: return "Error"
        case .critical: return "Critical"
        }
    }
}

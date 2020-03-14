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

/// Immutable struct encapsulating all log message data.
public struct Message {
    
    /// Log level of the log message.
    public let level: LogLevel
    
    /// Tag associated with the message.
    public let tag: String?
    
    /// Actual provided log message.
    public let text: String
    
    /// Meta information of the log message.
    public let meta: MetaInfo
}

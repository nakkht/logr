//
// Copyright 2020 Paulius Gudonis
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

/// Immutable struct for encapsulating meta information of the log message.
public struct MetaInfo: Equatable {

    /// Whole path to the file where log message was created.
    public let file: String

    /// Name of the function where log call happened.
    public let function: String

    /// Line number of the log call.
    public let line: Int

    /// Timestamp of when the  log message was created.
    public let timeStamp: Date

    /// Computed property for transforming MetaInfo struct into text line.
    public var text: String {
        return "\(fileName) \(function) \(line)"
    }

    /// Computed property for getting only file name from the `file` property.
    public var fileName: String {
        return !file.contains("/") ? file : String(file.split(separator: "/").last?.split(separator: ".").first ?? "")
    }
}

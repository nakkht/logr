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

/// Struct used to enapsulate configuration values, i.e. LogrService.
public struct Config {
    
    /// Targets assigned during initialization.
    public let targets: [Target]?
    
    /// Bool flag assigned during initialization.
    public let async: Bool
    
    /// Optional dispatch queue assigned during initialization.
    public let dispatchQueue: DispatchQueue?
    
    /// Initializes new immutable config struct with provided values.
    /// - Parameters:
    ///   - async: determines whether executions passed to the targets will be synchronous or asynchronous. Default: true
    ///   - dispatchQueue: dispatch queue onto which logging messages shall be dispatched to the targets.
    ///   - targets: array of targets to which logging messages shall be dispatched.
    public init(async: Bool = true, dispatchQueue: DispatchQueue? = nil, targets: [Target]? = nil) {
        self.targets = targets
        self.async = async
        self.dispatchQueue = dispatchQueue
    }
    
    /// Initializes new immutable config struct with provided values.
    /// - Parameters:
    ///   - async: determines whether executions passed to the targets will be synchronous or asynchronous. Default: true
    ///   - dispatchQueue: dispatch queue onto which logging messages shall be dispatched to the targets
    ///   - targets: variadic array of targets to which logging messages shall be dispatched
    public init(async: Bool = true, dispatchQueue: DispatchQueue? = nil, _ targets: Target...) {
        self.init(async: async, dispatchQueue: dispatchQueue, targets: targets)
    }
}

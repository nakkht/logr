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

/// Main logging service used for dispatching messages to dedicated targets for further processing.
public class LogrService {

    static var dispatchQueue = DispatchQueue(label: "logr.service", qos: .background)
    static var targets: [Target]?

    let async: Bool

    init() {
        self.async = true
    }

    /// Initializes new intance of LogrService with provided configuration. Overrides previously set `targets` and `dispatchQueue` properties.
    /// - Parameters:
    ///   - config: struct encapsulating configuration properties used by LogrService.
    ///   - dispatchQueue: queue to be used for handling incoming log messages and forwarding to  previously set targets.
    @discardableResult
    public init(with config: Config, dispatchQueue: DispatchQueue? = nil) {
        self.async = config.async
        LogrService.targets = config.targets
        if let dispatchQueue = dispatchQueue {
            LogrService.dispatchQueue = dispatchQueue
        }
    }

    /// Dispatches log messages to the targets based  on configuration: synchronously or asynchronously.
    /// - Parameters:
    ///     - message: struct encapsulating all log message data including meta information
    public func log(_ message: Message) {
        if async {
            LogrService.dispatchQueue.async { self.dispatchLog(message) }
        } else {
            LogrService.dispatchQueue.sync { self.dispatchLog(message) }
        }
    }

    func dispatchLog(_ message: Message) {
        LogrService.targets?.forEach { $0.send(message) }
    }
}

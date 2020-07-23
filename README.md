# Logr

[![build status](https://travis-ci.com/nakkht/logr.svg?branch=develop)](https://travis-ci.com/nakkht/logr)
![platforms](https://img.shields.io/badge/platforms-ios%20%7C%20osx%20%7C%20tvos-brightgreen)
[![codecov](https://codecov.io/gh/nakkht/logr/branch/develop/graph/badge.svg)](https://codecov.io/gh/nakkht/logr)
[![documentation](https://img.shields.io/badge/doc-reference-brightgreen)](https://nakkht.github.io/logr/)

Simple logging library for iOS written in Swift

## Features

- [x] Inferred tags
- [x] Swift Package Manager/Carthage/CocoaPods integration
- [x] Highly extensible
- [x] Logging to multiple targets/destination at the same time
- [x] Console logging out of the box via ConsoleTarget
- [x] File logging out of the box via FileTarget 
- [x] Pure Swift 5

## Integration

### Swift Package Manager

Once Swift package set up, add the following to your `Package.swift`:

```
dependencies: [
  .package(url: "https://github.com/nakkht/logr.git", exact: "0.7.0")
]
```

### Carthage

To add Logr to your project using Carthage, add the following to your `Cartfile`:

```
github "nakkht/logr" "0.7.0"
```

### CocoaPods

To integrate using CocoaPods, install [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) and include the following in your `Podfile`:

```
pod 'Logr', '~> 0.7.0'
```

## Usage

In your `AppDelegate.swift` file add:

```swift
import Logr
```

At the beginning of `func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool` configure logr service with wanted targets:

```swift
LogrService.init(with: Config(ConsoleTarget(), FileTarget()))
``` 

For more serious configuration in production, it is recommended to ommit `ConsoleTarget`. The following snippet is suggested:

```swift
#if DEBUG
static let targets: [Target] = [ConsoleTarget(), FileTarget()]
#else
static let targets: [Target] = [FileTarget()]
#endif

static let config = Config(targets: targets)

LogrService.init(with: config)
```

## Demo

Demo project can be access by opening Demo.workspace in Demo subfolder.

## Documentation

- [Documentation](https://nakkht.github.io/logr/) generated with [jazzy](https://github.com/realm/jazzy). Hosted by [GitHub Pages](https://pages.github.com).
- [Architecture document](https://github.com/nakkht/logr/wiki/Architecture) available in project wiki

## Author
* [Paulius Gudonis](https://pgu.dev)

## Licence
This repository is under the **Apache v2.0** license. [Find it here](https://github.com/nakkht/logr/blob/master/LICENSE).

    Copyright 2020 Paulius Gudonis

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

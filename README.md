# logr

[![Build Status](https://travis-ci.com/nakkht/logr.svg?branch=develop)](https://travis-ci.com/nakkht/logr)
[![codecov](https://codecov.io/gh/nakkht/logr/branch/develop/graph/badge.svg)](https://codecov.io/gh/nakkht/logr)
![Cocoapods platforms](https://img.shields.io/cocoapods/p/Logr?color=green)
[![codebeat badge](https://codebeat.co/badges/22ef8e2e-a141-4c24-94b3-3501d0fe9313)](https://codebeat.co/projects/github-com-nakkht-logr-master)

Simple logging library for iOS written in Swift

## Integration

### Swift Package Manager

```
dependencies: [
  .package(url: "https://github.com/nakkht/logr.git", exact: "0.3.1")
]
```

### CocoaPods

To integrate using CocoaPods, install [CocoaPods](https://cocoapods.org/pods/logr) and include the following in your Podfile:

```
target 'MyApp' do
  use_frameworks!
  pod 'Logr', '0.3.1'
end
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

For more serious configuration for production, `ConsolteTarget` should be omitted, the following snippet is suggested:

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

## Author
* [Paulius Gudonis](pg@neqsoft.com)

## Licence
This repository is under the **Apache v2.0** license. [Find it here](https://github.com/nakkht/logr/blob/master/LICENSE).

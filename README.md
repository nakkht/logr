# logr

[![Build Status](https://travis-ci.com/nakkht/logr.svg?branch=develop)](https://travis-ci.com/nakkht/logr)
[![codecov](https://codecov.io/gh/nakkht/logr/branch/develop/graph/badge.svg)](https://codecov.io/gh/nakkht/logr)

Simple logging library for iOS written in Swift

### Manual integration

* Add Logr project into your workspace in xcode
* Go to 'General' tab of your 'Target'
* Press '+' under 'Embedded binaries' and select Logr.framework

### CocoaPods

To integrate using CocoaPods, install [CocoaPods](https://guides.cocoapods.org/using/getting-started.html) and include the following in your Podfile:

```
target 'MyApp' do
  use_frameworks!
  pod 'Logr', '0.1.0'
end
```

### Demo

Demo project can be access by opening Demo.workspace in Demo subfolder.

### Author
* [Paulius Gudonis](pg@neqsoft.com)

### Licence
This repository is under the **Apache v2.0** license. [Find it here](https://github.com/nakkht/logr/blob/master/LICENSE).

# Changelog

All notable changes to logr project.

## v0.9.0 - [2020-10-01]

Added:
* Timestamp to message meta info
* Blocking sync call to ensure all messages are written into persistent storage

Fixed
* Auto archive based on archive file size and/or time span

Changed
* DispatchQueue is now directly set via target initializer rather than associated config


## v0.8.0 - [2020-09-21]

Added
* Tests for minimum logged level
* Swift 5.3 support

Changed
* WatchOS support to v3
* Code organization

Fixed
* `defaultDateTimeFormat` in FileTargetConfig missing full minutes

## v0.7.0 - [2020-07-23]

Added
* Optional headers for log files

## v0.6.1 - [2020-06-14]

Fixed
* `Package.swift` to use version 10.14 for the macOS platform 

## v0.6.0 - [2020-06-14]

Added
* Inferred tags
* tvOS support
* macOS support

## v0.5.0 - [2020-03-20]

Added
* Interactive demo
* More documentation
* Tag for `Logr` class

## v0.4.0 - [2019-11-13]

Added
* Carthage support (Inlcuded Logr.xcodeproj)

## v0.3.4 - [2019-11-12]

Fixed
* Creating archive folder if does not exist

## v0.3.3 - [2019-11-12]

Fixed
* Archive folder created as file instead of folder

## v0.3.2 - [2019-11-12]

Added
* Documentation for public apis
* Dispatch queue configuration for file target

Fixed
* Using wrong url for deleting/renaming archived files

## v0.3.1 - [2019-10-21]

Added
* Message struct
* More tests for FileTargetConfig

Fixed
* Access modifers for ConsoleTargetConfig/FileTargetConfig/Config initializers

## v0.3.0 - [2019-10-16]

Added
* Swift Package Manager support

Fixed
* Setting maxArchivedFilesCount in FileTargetConfig 

## v0.2.0 - [2019-09-18]

Added
* Logging to a file (FileTarget)
* Config option to set your own dispatch queue
* Log levels per target config

## v0.1.0 - [2019-08-18]

Added
* Main logging mechanism
* Target concept
* ConsoleTarget for logging to console

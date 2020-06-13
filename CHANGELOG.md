# Changelog

All notable changes to logr project.

## v0.6.0 - [2020-xx-xx]

Added:
* Inferred tags
* tvOS support

## v0.5.0 - [2020-03-20]

Added:
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

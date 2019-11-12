# Changelog

All notable changes to logr project.

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

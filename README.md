Try Dart Pirate Badge Sample
============================

[![Build Status](https://drone.io/github.com/dart-lang/one-hour-codelab/status.png)](https://drone.io/github.com/dart-lang/one-hour-codelab/latest)

These are small Dart samples used by the new
Try Dart 1-hour experience.

Repo and testing
----------------

Currently, drone.io tests only whether the .dart files under web/ pass static analysis (dartanalyzer). We could do real unit testing, and we could do better with HTML samples.

Project structure
-----------------

**web/:**
        Code samples used by the Try Dart 1-hour experience. Contains sub-directories to organize the samples by step.

**README.md:**
        This file.

**runtests.sh:**
	BASH script that runs dartanalyzer on all Dart source files in the web directory.

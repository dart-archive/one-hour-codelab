Avast, Ye Pirates: Write a Web App Code Lab
============================

[![Build Status](https://drone.io/github.com/dart-lang/one-hour-codelab/status.png)](https://drone.io/github.com/dart-lang/one-hour-codelab/latest)

These are small Dart samples used by the [Avast Ye, Pirates][codelab], in which you learn to build and web app, and which takes about an hour to complete.

Repo and testing
----------------

Currently, drone.io tests only whether the .dart files under web/ pass static analysis (dartanalyzer). We could do real unit testing, and we could do better with HTML samples.

Project structure
-----------------

**web/:**
        Code samples used by the Avast Ye, Pirates code lab. Contains sub-directories to organize the samples by step.

**README.md:**
        This file.

**runtests.sh:**
	BASH script that runs dartanalyzer on all Dart source files in the web directory.


[codelab]: https://www.dartlang.org/codelabs/darrrt/

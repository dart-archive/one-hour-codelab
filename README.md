Avast, Ye Pirates: Write a Web App Code Lab
============================

[![Build Status](https://drone.io/github.com/dart-lang/one-hour-codelab/status.png)](https://drone.io/github.com/dart-lang/one-hour-codelab/latest)

These are small Dart samples used by two codelabs: the [Avast Ye, Pirates][client-codelab], in which you learn to build and web app, and which takes about an hour to complete, and the [Beware the Nest o' Pirates][server-codelab] which shows you how to write a RESTful Dart server.

Repo and testing
----------------

Currently, drone.io tests only whether the .dart files under web/ pass static analysis (dartanalyzer). We could do real unit testing, and we could do better with HTML samples.

Project structure
-----------------

**1-blankbadge:**
**2-inputnamebadge:**
**3-buttonbadge:**
**4-classbadge:**
**5-localbadge:**
**6-piratebadge:**
        Code samples used by the Avast Ye, Pirates code lab. Contains sub-directories to organize the samples by step.

**2-1-starter**
**2-2-simple**
**2-4-extended**
**2-5-generated**
**2-6-client**
**2-7-serve**
        Code samples used by the Beware the Nest o' Pirates code lab. Contains sub-directories to organize the samples by step.

**README.md:**
        This file.

**runtests.sh:**
	BASH script that runs dartanalyzer on all Dart source files in the web directory.

[client-codelab]: https://www.dartlang.org/codelabs/darrrt/
[server-codelab]: https://www.dartlang.org/codelabs/server/

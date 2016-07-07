Dart Code Lab Samples
============================

[![Build Status](https://drone.io/github.com/dart-lang/one-hour-codelab/status.png)](https://drone.io/github.com/dart-lang/one-hour-codelab/latest)

These are small Dart samples used by two codelabs:

* [Avast Ye, Pirates][client-codelab], where you learn to build a web app. This lab should take about an hour to complete.
* [Beware the Nest o' Pirates][server-codelab] which shows you how to write a RESTful Dart server.

Repository and testing
----------------

Currently, drone.io tests only whether the .dart files under web/ pass static analysis (dartanalyzer). We could do real unit testing, and we could do better with HTML samples.

Project structure
-----------------

#### `darrrt/`
Code samples used by the original Avast Ye, Pirates code lab. Each numerical version corresponds to a step in the code lab.
```
1-blankbadge/
2-inputnamebadge/
3-buttonbadge/
4-classbadge/
5-final/
```

#### `ng2/`
Code samples used by the angular2 version of the Avast Ye, Pirates code lab. Each numerical version corresponds to a step in the code lab.
```
1-skeleton/
2-blankbadge/
3-inputnamebadge/
4-buttonbadge/
5-piratenameservice/
6-readjsonfile/
```

#### `server/`
Code samples used by the Beware the Nest o' Pirates code lab. Each numerical version corresponds to a step in the code lab.
```
1-starter/
2-simple/
4-extended/
5-generated/
6-client/
7-serve/
```

#### `README.md`
This file.

#### `runtests.sh`
BASH script that runs dartanalyzer on all Dart source files in the web directory.

[client-codelab]: https://www.dartlang.org/codelabs/darrrt/
[server-codelab]: https://www.dartlang.org/codelabs/server/

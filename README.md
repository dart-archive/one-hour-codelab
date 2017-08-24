Dart Code Lab Samples
============================
[![first-timers-only](http://img.shields.io/badge/first--timers--only-friendly-blue.svg?style=flat-square)](http://www.firsttimersonly.com/)

These are small Dart samples used by the following codelabs:

* [AngularDart Components Lottery Simulator][]. Beautify a web app by converting its vanilla HTML elements to Material
  Design components that are widely used in Google’s Dart apps.
* (**Deprecated**) [Avast Ye Pirates][ng2-codelab], where you learn to build an Angular 2 web app.
* (**Deprecated**) [Original pirate codelab written using dart:html][client-codelab], where you learn to build a web app.
* (**Needs updates**) [Beware the Nest o' Pirates][server-codelab], which shows you how to write a RESTful Dart server.

For links to the latest Dart codelabs, see [dartlang.org/codelabs](https://www.dartlang.org/codelabs).

Repository structure
-----------------

- Each top-level folder holds the sources to an individual codelab.
- `runtests.sh`: bash script that runs dartanalyzer on all Dart source files in the web directory.

Testing
----------------

Currently, drone.io tests only whether the .dart files under web/ pass static analysis (dartanalyzer). We could do real unit testing, and we could do better with HTML samples.

[AngularDart Components Lottery Simulator]: https://webdev.dartlang.org/codelabs/angular_components
[client-codelab]: https://webdev.dartlang.org/codelabs/darrrt
[ng2-codelab]:    https://webdev.dartlang.org/codelabs/ng2
[server-codelab]: https://dart-lang.github.io/server/codelab/

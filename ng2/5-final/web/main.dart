// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/bootstrap.dart';
import 'package:pirate_badge/app.dart';
import 'package:angular2/angular2.dart';
import 'dart:math';

import 'package:pirate_badge/services/pirate_name_service.dart';

main() {
  bootstrap(App,
      [provide(Random, useValue: new Random()), PirateNameService]);
}

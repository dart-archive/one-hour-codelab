// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pirate.messages;

import 'dart:convert' show JSON;

class Pirate {
  String name;
  String appellation;

  // A message class must have a default constructor taking no arguments.
  Pirate();

  // It is fine to have other named constructors.
   Pirate.fromJSON(String jsonString) {
    Map storedName = JSON.decode(jsonString);
    name = storedName['f'];
    appellation = storedName['a'];
  }

  Pirate.fromString(String pirateName) {
    var parts = pirateName.split(' the ');
    name = parts[0];
    appellation = parts[1];
  }

  String get jsonString => JSON.encode({"f": name, "a": appellation});

  String toString() => name.isEmpty ? '' : '$name the $appellation';
}

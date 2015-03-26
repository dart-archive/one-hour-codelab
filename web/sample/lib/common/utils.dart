// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pirate.utils;

import 'dart:math' show Random;

import 'messages.dart';

List<String> _forbiddenAppellations = [
  null,
  '',
  'sweet',
  'pretty',
  'beautiful',
  'weak',
  'wuss',
  'chicken',
  'afraid',
];

// Helper method for validating whether the given pirate is truly a pirate!
bool truePirate(Pirate pirate) =>
    !_forbiddenAppellations.contains(pirate.appellation.toLowerCase());

// Class for shanghaiing (generating) pirates.
class PirateShanghaier {
  static final Random indexGen = new Random();

  List<String> names = [];
  List<String> appellations = [];

  PirateShanghaier(Map<String, List<String>> properPirates) {
    names = properPirates['names'];
    appellations = properPirates['appellations'];
  }

  Pirate shanghaiPirate({String name, String appellation}) {
    var pirate = new Pirate();
    pirate.name = name != null ? name : names[indexGen.nextInt(names.length)];
    pirate.appellation = appellation != null ?
        appellation : appellations[indexGen.nextInt(appellations.length)];
    return truePirate(pirate) ? pirate : null;
  }
}
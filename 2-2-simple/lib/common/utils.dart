// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pirate.utils;

import 'dart:math' show Random;

import 'messages.dart';

// Proper pirate names and appellations.
const Map<String, List<String>> properPirateNames = const {
"names": const [ "Anne", "Bette", "Cate", "Dawn",
     "Elise", "Faye", "Ginger", "Harriot",
     "Izzy", "Jane", "Kaye", "Liz",
     "Maria", "Nell", "Olive", "Pat",
     "Queenie", "Rae", "Sal", "Tam",
     "Uma", "Violet", "Wilma", "Xana",
     "Yvonne", "Zelda",
     "Abe", "Billy", "Caleb", "Davie",
     "Eb", "Frank", "Gabe", "House",
     "Icarus", "Jack", "Kurt", "Larry",
     "Mike", "Nolan", "Oliver", "Pat",
     "Quib", "Roy", "Sal", "Tom",
     "Ube", "Val", "Walt", "Xavier",
     "Yvan", "Zeb"],
"appellations": const [ "Awesome", "Captain",
     "Even", "Fighter", "Great", "Hearty",
     "Jackal", "King", "Lord",
     "Mighty", "Noble", "Old", "Powerful",
     "Quick", "Red", "Stalwart", "Tank",
     "Ultimate", "Vicious", "Wily", "aXe", "Young",
     "Brave", "Eager",
     "Kind", "Sandy",
     "Xeric", "Yellow", "Zesty"]
};

// Clearly invalid pirate appellations.
const List<String> _forbiddenAppellations = const [
  null,
  '',
  'sweet',
  'handsome',
  'beautiful',
  'weak',
  'wuss',
  'chicken',
  'fearful',
];

// Helper method for validating whether the given pirate is truly a pirate!
bool truePirate(Pirate pirate) => pirate.name != null &&
    pirate.name.trim().isNotEmpty &&
    !_forbiddenAppellations
        .contains(pirate.appellation.toLowerCase());

// Class for shanghaiing (generating) pirates.
class PirateShanghaier {
  static final Random indexGen = new Random();

  List<String> names = [];
  List<String> appellations = [];

  PirateShanghaier(Map<String, List<String>> properPirates) {
    names = properPirates['names'];
    appellations = properPirates['appellations'];
  }

  Pirate shanghaiAPirate({String name, String appellation}) {
    var pirate = new Pirate();
    pirate.name =
        name != null ? name : names[indexGen.nextInt(names.length)];
    pirate.appellation = appellation != null
        ? appellation
        : appellations[indexGen.nextInt(appellations.length)];
    return truePirate(pirate) ? pirate : null;
  }
}

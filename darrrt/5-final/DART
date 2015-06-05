// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Demonstrates:
// list, maps, random, strings, string interpolation
// cascade, fat arrow, ternary operator
// named constructors
// optional parameters
// a class
// getters
// static class-level methods/fields
// top-level variables and functions
// typecasting with 'as'
// import, also with show
// dart:core, html, math, convert and async libraries

// In Step 5 of the code lab (dartlang.org/codelabs/darrrt/),
// you read the pirate names from a JSON file.

import 'dart:html';
import 'dart:math' show Random;
import 'dart:convert' show JSON;
import 'dart:async' show Future;

ButtonElement genButton;
SpanElement badgeNameElement;

main() async {
  InputElement inputField = querySelector('#inputName');
  inputField.onInput.listen(updateBadge);
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);

  badgeNameElement = querySelector('#badgeName');

  try {
    await PirateName.readyThePirates();
    // on success
    inputField.disabled = false; //enable
    genButton.disabled = false; //enable
  } catch (arrr) {
    print('Error initializing pirate names: $arrr');
    badgeNameElement.text = 'Arrr! No names.';
  }
}

void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;

  setBadgeName(new PirateName(firstName: inputName));
  if (inputName.trim().isEmpty) {
    genButton
      ..disabled = false
      ..text = 'Aye! Gimme a name!';
  } else {
    genButton
      ..disabled = true
      ..text = 'Arrr! Write yer name!';
  }
}

void generateBadge(Event e) {
  setBadgeName(new PirateName());
}

void setBadgeName(PirateName newName) {
  if (newName == null) return;

  badgeNameElement.text = newName.pirateName;
}

class PirateName {
  static final Random indexGen = new Random();

  static List<String> names = [];
  static List<String> appellations = [];

  String _firstName;
  String _appellation;

  PirateName({String firstName, String appellation}) {
    if (firstName == null) {
      _firstName = names[indexGen.nextInt(names.length)];
    } else {
      _firstName = firstName;
    }
    if (appellation == null) {
      _appellation =
          appellations[indexGen.nextInt(appellations.length)];
    } else {
      _appellation = appellation;
    }
  }

  String toString() => pirateName;

  String get pirateName =>
      _firstName.isEmpty ? '' : '$_firstName the $_appellation';

  static Future readyThePirates() async {
    String path =
        'https://www.dartlang.org/codelabs/darrrt/files/piratenames.json';
    String jsonString = await HttpRequest.getString(path);
    _parsePirateNamesFromJSON(jsonString);
  }

  static void _parsePirateNamesFromJSON(String jsonString) {
    Map pirateNames = JSON.decode(jsonString);
    names = pirateNames['names'];
    appellations = pirateNames['appellations'];
  }
}

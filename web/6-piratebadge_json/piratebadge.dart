// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.


// Demonstrates:
// list, maps, random, strings, string interpolation, cascade, fat arrow,
// named constructors.
// optional parameters.
// a class
// getters, setters
// httprequest, JSON
// local storage
// static class-level methods/fields
// top-level variable and functions
// typecasting with 'as'
// futures
// import, also with show

import 'dart:html';
import 'dart:math' show Random;
import 'dart:convert' show JSON;
import 'dart:async' show Future;

final String TREASUREKEY = 'pirateName';

SpanElement badgeNameElement;
ButtonElement genButton;

void  main() {
  InputElement inputField = query('#inputName')
      ..onInput.listen(updateBadge);
  genButton = query('#generateButton')
      ..onClick.listen(generateBadge);
  
  badgeNameElement = query('#badgeName');
  
  PirateName.readyThePirates()
    .then((_) {
      inputField.disabled = false; //enable
      genButton.disabled = false;  //enable
      badgeName = pirateNameFromStorage;
    })
    .catchError((arrr) {
      print('Error initializing pirate names: $arrr');
      badgeNameElement.text = 'Arrr! No names.';
    });
}

void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;
  
  badgeName = new PirateName(firstName: inputName);
  if (inputName.trim().isEmpty) {
    genButton..disabled = false
             ..text = 'Generate badge';
  } else {
    genButton..disabled = true
             ..text = 'Arrr! Remove the text!';
  }
}

void generateBadge(Event e) {
  badgeName = new PirateName();
}

set badgeName(PirateName newName) {
  badgeNameElement.text = newName.pirateName;
  window.localStorage[TREASUREKEY] = newName.toJsonString();
}

PirateName get pirateNameFromStorage {
  String storedName = window.localStorage[TREASUREKEY];
  if (storedName != null) {
    return new PirateName.fromJSON(storedName);
  } else {
    return null;
  }
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
      _appellation = appellations[indexGen.nextInt(appellations.length)];
    } else {
      _appellation = appellation;
    }
  }

  PirateName.fromJSON(String jsonString) {
    Map storedName = JSON.decode(jsonString);
    _firstName = storedName['f'];
    _appellation = storedName['a'];
  }

  String toString() => pirateName;

  String toJsonString() => '{ "f": "$_firstName", "a": "$_appellation" } ';

  String get pirateName => '$_firstName the $_appellation';

  static Future readyThePirates() {
    String path = 'piratenames.json';
    return HttpRequest.getString(path)
        .then(_parsePirateNamesFromJSON);
  }
  
  static _parsePirateNamesFromJSON(String jsonString) {
    Map pirateNames = JSON.decode(jsonString);
    names = pirateNames['names'];
    appellations = pirateNames['appellations'];
  }
}
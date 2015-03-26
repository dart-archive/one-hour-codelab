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
// httprequest, JSON
// local storage
// static class-level methods/fields
// top-level variables and functions
// typecasting with 'as'
// futures
// import, also with show
// dart:core, html, math, convert and async libraries

import 'dart:async';
import 'dart:html';

import 'package:http/browser_client.dart';
import 'package:sample/client/piratesapi.dart';
import 'package:sample/common/messages.dart';
import 'package:sample/common/utils.dart';

final String TREASURE_KEY = 'pirateName';

ButtonElement genButton;
ButtonElement storeButton;
ButtonElement killButton;
SpanElement badgeNameElement;
SelectElement pirateList;

final _client = new BrowserClient();
final PiratesApi _api = new PiratesApi(_client);
PirateShanghaier _shanghaier;

Future main() async {
  var properPirates = await _api.properPirates();
  _shanghaier = new PirateShanghaier(properPirates);

  InputElement inputField = querySelector('#inputName');
  inputField.onInput.listen(updateBadge);
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);
  inputField.disabled = false; //enable
  genButton.disabled = false;  //enable
  badgeNameElement = querySelector('#badgeName');
  storeButton = querySelector('#storeButton');
  storeButton.onClick.listen(storeBadge);
  pirateList = querySelector('#pirateList');
  pirateList.onClick.listen(selectListener);
  killButton = querySelector('#killButton');
  killButton.onClick.listen(removeBadge);
  setBadgeName(getBadgeNameFromStorage());
  refreshList();
}

Future refreshList() async {
  List<Pirate> pirates = await _api.listPirates();
  pirateList.children.clear();
  pirates.forEach((pirate) {
    var option = new OptionElement(data: pirate.toString());
    pirateList.add(option, 0);
  });
}

void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value;
  var pirate = _shanghaier.shanghaiPirate(name: inputName);
  setBadgeName(pirate);
  if (inputName.trim().isEmpty) {
    genButton..disabled = false
             ..text = 'Aye! Gimme a name!';
  } else {
    genButton..disabled = true
             ..text = 'Arrr! Write yer name!';
  }
}

Future storeBadge(Event e) async {
  var pirateName = badgeNameElement.text;
  if (pirateName == null || pirateName.isEmpty) return;
  var pirate = new Pirate.fromString(pirateName);
  await _api.addPirate(pirate);
  storeButton
      ..disabled = true
      ..text = 'Pirate hired!';
  refreshList();
}

Future selectListener(Event e) async {
  killButton.disabled = false;
}

Future removeBadge(Event e) async {
  var idx = pirateList.selectedIndex;
  if (idx < 0 || idx >= pirateList.size) return;
  var option = pirateList.options.elementAt(idx);
  var pirate = new Pirate.fromString(option.label);
  await _api.killPirate(pirate.name, pirate.appellation);
  killButton.disabled = true;
  refreshList();
}

void generateBadge(Event e) {
  var pirate = _shanghaier.shanghaiPirate();
  setBadgeName(pirate);
}

void setBadgeName(Pirate pirate) {
  if (pirate == null) {
    return;
  }
  badgeNameElement.text = pirate.toString();
  window.localStorage[TREASURE_KEY] = pirate.jsonString;
  storeButton
      ..disabled = false
      ..text = 'Hire Pirate!';
}

Pirate getBadgeNameFromStorage() {
  String storedName = window.localStorage[TREASURE_KEY];
  if (storedName != null) {
    return new Pirate.fromJSON(storedName);
  } else {
    return null;
  }
}

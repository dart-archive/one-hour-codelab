// Copyright (c) 2012, 2015 the Dart project authors.
// Please see the AUTHORS file for details. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:html';

import 'package:http/browser_client.dart';
import 'package:server_code_lab/client/piratesapi.dart';
import 'package:server_code_lab/common/messages.dart';
import 'package:server_code_lab/common/utils.dart';

final String TREASURE_KEY = 'pirateName';

ButtonElement genButton;
ButtonElement storeButton;
ButtonElement fireButton;
ButtonElement slayButton;
SpanElement badgeNameElement;
SelectElement pirateList;

// By default the generated client code uses
// 'http://localhost:8080/'. Since our server is running on
// port 8088 we override the default url when instantiating
// the generated PiratesApi class.
final String _serverUrl = 'localhost:8088/';
final BrowserClient _client = new BrowserClient();
PiratesApi _api;
PirateShanghaier _shanghaier;

Future main() async {
  // We need to determine if the client is using http or https
  // and use the same protocol for the client stub requests
  // (the protocol includes the ':').
  var protocol = window.location.protocol;
  if (!['http:', 'https:'].contains(protocol)) {
    // Default to http if unknown protocol.
    protocol = 'http:';
  }
  _api = new PiratesApi(_client, rootUrl: '$protocol//$_serverUrl');
  _shanghaier = new PirateShanghaier();

  InputElement inputField = querySelector('#inputName');
  inputField.onInput.listen(updateBadge);
  genButton = querySelector('#generateButton');
  genButton.onClick.listen(generateBadge);
  inputField.disabled = false; //enable
  genButton.disabled = false; //enable
  badgeNameElement = querySelector('#badgeName');
  storeButton = querySelector('#storeButton');
  storeButton.onClick.listen(storeBadge);
  pirateList = querySelector('#pirateList');
  pirateList.onClick.listen(selectListener);
  fireButton = querySelector('#fireButton');
  fireButton.onClick.listen(removeBadge);
  slayButton = querySelector('#slayButton');
  slayButton.onClick.listen(removeAllBadges);
  setBadgeName(getBadgeNameFromStorage());
  refreshList();

  var buttons = querySelectorAll("button");
  buttons.onClick.listen(addRippleEffect);
}

Future refreshList() async {
  List<Pirate> pirates = await _api.listPirates();
  pirateList.children.clear();
  pirates.forEach((pirate) {
    var option = new OptionElement(data: pirate.toString());
    pirateList.add(option, 0);
  });

  var disabled = true;
  if (pirateList.length > 0) {
    disabled = false;
  }

  new Future.delayed(new Duration(milliseconds: 300), () {
    slayButton.disabled = disabled;
  });
}

void updateBadge(Event e) {
  String inputName = (e.target as InputElement).value.trim();
  var pirate = _shanghaier.shanghaiAPirate(name: inputName);
  setBadgeName(pirate);
  if (inputName.trim().isEmpty) {
    genButton
      ..disabled = false
      ..text = 'Aye! Gimme a name!';
    storeButton..disabled = true;
  } else {
    genButton
      ..disabled = true
      ..text = 'Arrr! Write yer name!';
    storeButton..disabled = false;
  }
}

Future storeBadge(Event e) async {
  var pirateName = badgeNameElement.text;
  if (pirateName == null || pirateName.isEmpty) return null;
  var pirate = new Pirate.fromString(pirateName);
  try {
    await _api.hirePirate(pirate);
  } catch (error) {
    window.alert(error.message);
  }
  new Future.delayed(new Duration(milliseconds: 300), () {
    storeButton
      ..disabled = true
      ..text = 'Pirate hired!';
  });
  refreshList();
}

Future selectListener(Event e) async {
  fireButton.disabled = false;
}

Future removeBadge(Event e) async {
  var idx = pirateList.selectedIndex;
  if (idx < 0 || idx >= pirateList.options.length) return null;
  var option = pirateList.options.elementAt(idx);
  var pirate = new Pirate.fromString(option.label);
  try {
    await _api.firePirate(pirate.name, pirate.appellation);
  } catch (error) {
    window.alert(error.message);
  }
  new Future.delayed(new Duration(milliseconds: 300), () {
    fireButton.disabled = true;
  });
  refreshList();
}

Future removeAllBadges(Event e) async {
  for (var option in pirateList.options) {
    var pirate = new Pirate.fromString(option.label);
    try {
      await _api.firePirate(pirate.name, pirate.appellation);
    } catch (error) {
      // ignoring errors.
    }
  }
  new Future.delayed(new Duration(milliseconds: 300), () {
    fireButton.disabled = true;
    slayButton.disabled = true;
  });
  refreshList();
}

void generateBadge(Event e) {
  var pirate = _shanghaier.shanghaiAPirate();
  setBadgeName(pirate);
}

void setBadgeName(Pirate pirate) {
  if (pirate == null || pirate.toString().isEmpty) {
    badgeNameElement.text = '';
    storeButton.disabled = true;
    return;
  }
  badgeNameElement.text = pirate.toString();
  window.localStorage[TREASURE_KEY] = pirate.toString();
  storeButton
    ..disabled = false
    ..text = 'Hire pirate!';
}

Pirate getBadgeNameFromStorage() {
  String storedName = window.localStorage[TREASURE_KEY];
  if (storedName != null && storedName.contains(' the ')) {
    return new Pirate.fromString(storedName);
  } else {
    return null;
  }
}

void addRippleEffect(MouseEvent e) {
  var button = e.target as ButtonElement;
  var ripple = button.querySelector(".ripple");

  // we need to delete existing ripple element
  if (ripple != null) {
    ripple.remove();
  }

  var x = e.client.x - button.getBoundingClientRect().left;
  var y = e.client.y - button.getBoundingClientRect().top;

  ripple = new SpanElement()
    ..classes.add("ripple")
    ..style.left = "${x}px"
    ..style.top = "${y}px"
    ..classes.add("show");

  button.append(ripple);
}

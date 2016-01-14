// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart' show Component;
import 'package:pirate_badge/services/pirate_name.dart'
    show PirateNameService;

@Component(
    selector: 'pirate-badge',
    templateUrl: 'pirate_badge_component.html')
class PirateBadge {
  String badgeName = "";
  String buttonText = "Aye! Gimme a name!";
  bool enableButton = false;
  bool enableInput = false;

  PirateBadge() {
    PirateNameService.readyThePirates().then((_) {
      enableButton = true;
      enableInput = true;
    }).catchError((arrr) {
      badgeName = 'Arrr! No names.';
      print('Error initializing pirate names: $arrr');
    });
  }

  void generateBadge() => setBadgeName(new PirateNameService());

  void setBadgeName(PirateNameService newName) {
    if (newName == null) return;
    badgeName = newName.pirateName;
  }

  void updateBadge(String inputName) {
    setBadgeName(new PirateNameService(firstName: inputName));
    if (inputName.trim().isEmpty) {
      buttonText = 'Aye! Gimme a name!';
      enableButton = true;
    } else {
      buttonText = 'Arrr! Write yer name!';
      enableButton = false;
    }
  }
}

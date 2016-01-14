// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart' show Component;

@Component(
    selector: 'pirate-badge',
    templateUrl: 'pirate_badge_component.html')
class PirateBadge {
  String badgeName = "";
  String buttonText = "Aye! Gimme a name!";
  bool enableButton = true;
  bool enableInput = true;

  void generateBadge() {
    badgeName = 'Anne Bonney';
  }

  void updateBadge(String inputName) {
    badgeName = inputName.toString();
    if (inputName.trim().isEmpty) {
      buttonText = 'Aye! Gimme a name!';
      enableButton = true;
    } else {
      buttonText = 'Arrr! Write yer name!';
      enableButton = false;
    }
  }
}

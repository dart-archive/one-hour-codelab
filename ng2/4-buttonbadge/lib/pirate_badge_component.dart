// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

@Component(
    selector: 'pirate-badge',
    templateUrl: 'pirate_badge_component.html',
    styleUrls: const ['pirate_badge_component.css'])
class PirateBadgeComponent {
  String badgeName = '';
  String buttonText = 'Aye! Gimme a name!';
  bool enableButton = true;

  void generateBadge() {
    badgeName = 'Anne Bonney';
  }

  void updateBadge(String inputName) {
    badgeName = inputName;
    if (inputName.trim().isEmpty) {
      buttonText = 'Aye! Gimme a name!';
      enableButton = true;
    } else {
      buttonText = 'Arrr! Write yer name!';
      enableButton = false;
    }
  }
}

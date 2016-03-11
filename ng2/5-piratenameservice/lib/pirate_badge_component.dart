// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'pirate_name_service.dart';

@Component(
    selector: 'pirate-badge',
    templateUrl: 'pirate_badge_component.html',
    providers: const [PirateNameService])
class PirateBadgeComponent {
  final PirateNameService _nameService;
  String badgeName = '';
  String buttonText = 'Aye! Gimme a name!';
  bool enableButton = true;
  bool enableInput = true;

  PirateBadgeComponent(this._nameService);

  void generateBadge() {
    setBadgeName();
  }

  void setBadgeName([String newName = '']) {
    if (newName == null) return;
    badgeName = _nameService.getPirateName(newName);
  }

  void updateBadge(String inputName) {
    setBadgeName(inputName);
    if (inputName.trim().isEmpty) {
      buttonText = 'Aye! Gimme a name!';
      enableButton = true;
    } else {
      buttonText = 'Arrr! Write yer name!';
      enableButton = false;
    }
  }
}
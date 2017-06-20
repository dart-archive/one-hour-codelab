// Copyright (c) 2017, the Dart project authors.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:angular2/angular2.dart';

import 'name_service.dart';

@Component(
  selector: 'pirate-badge',
  templateUrl: 'badge_component.html',
  styleUrls: const ['badge_component.css'],
  providers: const [NameService],
)
class BadgeComponent {
  final NameService _nameService;
  String badgeName = '';
  String buttonText = 'Aye! Gimme a name!';
  bool isButtonEnabled = true;

  BadgeComponent(this._nameService);

  void generateBadge() {
    setBadgeName();
  }

  void updateBadge(String inputName) {
    setBadgeName(inputName);
    if (inputName.trim().isEmpty) {
      buttonText = 'Aye! Gimme a name!';
      isButtonEnabled = true;
    } else {
      buttonText = 'Arrr! Write yer name!';
      isButtonEnabled = false;
    }
  }

  void setBadgeName([String newName = '']) {
    if (newName == null) return;
    badgeName = _nameService.getPirateName(newName);
  }
}

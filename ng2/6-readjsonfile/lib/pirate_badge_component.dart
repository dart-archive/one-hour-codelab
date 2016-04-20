// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';
import 'pirate_name_service.dart';

@Component(
    selector: 'pirate-badge',
    templateUrl: 'pirate_badge_component.html',
    styleUrls: const ['pirate_badge_component.css'],
    providers: const [PirateNameService])
class PirateBadgeComponent implements OnInit {
  final PirateNameService _nameService;
  String badgeName = '';
  String buttonText = 'Aye! Gimme a name!';
  bool enableButton = false;
  bool enableInput = false;

  PirateBadgeComponent(this._nameService);

  ngOnInit() async {
    try {
      await _nameService.readyThePirates();
      //on success
      enableButton = true;
      enableInput = true;
    } catch (arrr) {
      badgeName = 'Arrr! No names.';
      print('Error initializing pirate names: $arrr');
    }
  }

  void generateBadge() {
    setBadgeName();
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

  void setBadgeName([String newName = '']) {
    if (newName == null) return;
    badgeName = _nameService.getPirateName(newName);
  }
}

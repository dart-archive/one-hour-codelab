// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';
import '../services/pirate_name.dart' show PirateName;

@Component(
    selector: 'pirate-badge',
    templateUrl: 'pirate_badge.html')
class PirateBadge implements OnInit {
  String badgeName = "";
  String buttonText = "Aye! Gimme a name!";
  bool enableButton = false;
  bool enableInput = false;

  ngOnInit() async {
    try {
      await PirateName.readyThePirates();
      //on success
      enableButton = true;
      enableInput = true;
    } catch (arrr) {
      badgeName = 'Arrr! No names.';
      print('Error initializing pirate names: $arrr');
    }
  }

  generateBadge() => setBadgeName(new PirateName());

  void setBadgeName(PirateName newName) {
    if (newName == null) return;
    badgeName = newName.pirateName;
  }

  void updateBadge(String inputName) {
    setBadgeName(new PirateName(firstName: inputName));
    if (inputName.trim().isEmpty) {
      buttonText = 'Aye! Gimme a name!';
      enableButton = true;
    } else {
      buttonText = 'Arrr! Write yer name!';
      enableButton = false;
    }
  }
}
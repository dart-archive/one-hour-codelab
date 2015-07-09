// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pirate.server;

import 'package:rpc/rpc.dart';

import '../common/messages.dart';
import '../common/utils.dart';

// This class defines the interface that the server provides.
class PiratesApi {
  final Map<String, Pirate> _pirateCrew = {};
  final PirateShanghaier _shanghaier = new PirateShanghaier();

  PiratesApi() {
    var captain = new Pirate.fromString('Lars the Captain');
    _pirateCrew[captain.toString()] = captain;
  }

  // Returns a list of the pirate crew.
  List<Pirate> listPirates() {
    return _pirateCrew.values.toList();
  }

  // Generates (shanghais) and returns a new pirate.
  // Does not add the new pirate to the crew.
  Pirate shanghaiAPirate() {
    var pirate = _shanghaier.shanghaiAPirate();
    if (pirate == null) {
      throw new InternalServerError('Ran out of pirates!');
    }
    return pirate;
  }
}

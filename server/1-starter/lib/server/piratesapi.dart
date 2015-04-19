// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pirate.server;

import 'package:rpc/rpc.dart';

import '../common/messages.dart';
import '../common/utils.dart';

// This class defines the interface that the server provides.
class PiratesApi {
  final Map<int, Pirate> _pirateCrew = {};
  final PirateShanghaier _shanghaier =
      new PirateShanghaier(properPirateNames);

  List<Pirate> listPirates() {
    return _pirateCrew.values.toList();
  }

  Pirate shanghaiAPirate() {
    var pirate = _shanghaier.shanghaiAPirate();
    if (pirate == null) {
      throw new InternalServerError('Ran out of pirates!');
    }
    _pirateCrew[pirate.toString().hashCode] = pirate;
    return pirate;
  }
}

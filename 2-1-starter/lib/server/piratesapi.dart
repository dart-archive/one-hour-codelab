// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pirate.server;

import 'dart:convert' show JSON;
import 'dart:io';
import 'package:rpc/rpc.dart';

import '../common/messages.dart';
import '../common/utils.dart';

class PiratesApi {
  final Map<int, Pirate> _alivePirates = {};
  PirateShanghaier _shanghaier;
  Map<String, List<String>> _properPirates;

  PiratesApi() {
    var namesFile =
        new File('packages/server_code_lab/server/piratenames.json');
    _properPirates = JSON.decode(namesFile.readAsStringSync());
    _shanghaier = new PirateShanghaier(_properPirates);
  }

  List<Pirate> listPirates() {
    return _alivePirates.values.toList();
  }

  Pirate shanghaiAPirate() {
    var pirate = _shanghaier.shanghaiAPirate();
    if (pirate == null) {
      throw new InternalServerError('Ran out of pirates!');
    }
    _alivePirates[pirate.toString().hashCode] = pirate;
    return pirate;
  }
}

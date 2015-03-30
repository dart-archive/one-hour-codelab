// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pirate.server;

import 'dart:convert' show JSON;
import 'dart:io';
import 'package:rpc/rpc.dart';

import '../common/messages.dart';
import '../common/utils.dart';

@ApiClass(version: 'v1')
class PiratesApi {
  final Map<int, Pirate> _alivePirates = {};
  PirateShanghaier _shanghaier;
  Map<String, List<String>> _properPirates;

  PiratesApi() {
    var namesFile = new File('packages/sample/server/piratenames.json');
    _properPirates = JSON.decode(namesFile.readAsStringSync());
    _shanghaier = new PirateShanghaier(_properPirates);
  }

  @ApiMethod(method: 'POST', path: 'pirate')
  Pirate addPirate(Pirate newPirate) {
    // Make sure this is a real pirate...
    if (!truePirate(newPirate)) {
      throw new BadRequestError(
          '$newPirate cannot be a pirate. Tis is not a pirate name!');
    }

    // Add pirate to store.
    _alivePirates[newPirate.toString().hashCode] = newPirate;
    return newPirate;
  }

  @ApiMethod(method: 'DELETE', path: 'pirate/{name}/the/{appellation}')
  Pirate killPirate(String name, String appellation) {
    var pirate = new Pirate()..name = name..appellation = appellation;
    if (!_alivePirates.containsKey(pirate.toString().hashCode)) {
      throw new NotFoundError('Could not find pirate \'${pirate.toString()}\'! '
                              'Maybe (s)he has abandoned ship!');
    }
   return _alivePirates.remove(pirate.toString().hashCode);
  }

  @ApiMethod(method: 'GET', path: 'pirates')
  List<Pirate> listPirates() {
    return _alivePirates.values.toList();
  }

  @ApiMethod(path: 'shanghai') // Default HTTP method is GET.
  Pirate shanghaiPirate() {
    var pirate = _shanghaier.shanghaiPirate();
    if (pirate == null) {
      throw new InternalServerError('Ran out of pirates!');
    }
    _alivePirates[pirate.hashCode] = pirate;
    return pirate;
  }

  @ApiMethod(path: 'proper/pirates')
  Map<String, List<String>> properPirates() {
    return _properPirates;
  }
}


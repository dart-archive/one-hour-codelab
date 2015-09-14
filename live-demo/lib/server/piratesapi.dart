// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pirate.server;

import 'package:gcloud/service_scope.dart' as scope;
import 'package:rpc/rpc.dart';

import '../common/messages.dart';
import '../common/utils.dart';

// This class defines the interface that the server provides.
@ApiClass(version: 'v1')
class PiratesApi {
  final Map<String, Map<String, Pirate>> _pirateCrews = {};
  final PirateShanghaier _shanghaier = new PirateShanghaier();

  // Getter to maintain a per user pirate crew.
  Map<String, Pirate> get pirateCrew {
    var sessionId = scope.lookup(#pirate.sessionId);
    assert(sessionId != null);
    var crew = _pirateCrews[sessionId];
    if (crew == null) {
      crew = {};
      var captain = new Pirate.fromString('Lars the Captain');
      crew[captain.toString()] = captain;
      _pirateCrews[sessionId] = crew;
    }
    return crew;
  }

  @ApiMethod(method: 'POST', path: 'pirate')
  Pirate hirePirate(Pirate newPirate) {
    // Make sure this is a real pirate...
    if (!truePirate(newPirate)) {
      throw new BadRequestError(
          '$newPirate cannot be a pirate. \'Tis not a pirate name!');
    }
    var pirateName = newPirate.toString();
    if (pirateCrew.containsKey(pirateName)) {
      throw new BadRequestError(
          '$newPirate is already part of your crew!');
    }

    // Add pirate to store.
    pirateCrew[pirateName] = newPirate;
    return newPirate;
  }

  @ApiMethod(method: 'DELETE', path: 'pirate/{name}/the/{appellation}')
  Pirate firePirate(String name, String appellation) {
    var pirate = new Pirate()
      ..name = Uri.decodeComponent(name)
      ..appellation = Uri.decodeComponent(appellation);
    var pirateName = pirate.toString();
    if (!pirateCrew.containsKey(pirateName)) {
      throw new NotFoundError(
          'Could not find pirate \'$pirate\'!' +
          'Maybe they\'ve abandoned ship!');
    }
    return pirateCrew.remove(pirateName);
  }

  @ApiMethod(method: 'GET', path: 'pirates')
  List<Pirate> listPirates() {
    return pirateCrew.values.toList();
  }

  @ApiMethod(path: 'shanghai') // Default HTTP method is GET.
  Pirate shanghaiAPirate() {
    var pirate = _shanghaier.shanghaiAPirate();
    if (pirate == null) {
      throw new InternalServerError('Ran out of pirates!');
    }
    return pirate;
  }
}

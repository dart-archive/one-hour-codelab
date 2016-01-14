// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math';

import 'package:angular2/angular2.dart' show Injectable;

@Injectable()
class PirateNameService {
  // injected by DI
  final Random _indexGen;

  // These will be filled after fetching the names from the server
  // using readyThePirates.
  final List<String> _names = [];
  final List<String> _appellations = [];

  bool _piratesLoaded = false;

  PirateNameService(this._indexGen);

  Future readyThePirates() async {
    final path = 'https://www.dartlang.org/codelabs/darrrt/files/'
        'piratenames.json';
    final jsonString = await HttpRequest.getString(path);
    final pirateNames = JSON.decode(jsonString);
    _names.addAll(pirateNames['names']);
    _appellations.addAll(pirateNames['appellations']);

    _piratesLoaded = true;
  }

  String getPirateName({String firstName, String appellation}) {
    if (!_piratesLoaded) throw new Exception(
        'Wait for Future from readThePirates method to finish'
        'before asking for pirate names.');

    firstName ??= _names[_indexGen.nextInt(_names.length)];
    appellation ??=
        _appellations[_indexGen.nextInt(_appellations.length)];

    return firstName.isEmpty ? '' : '$firstName the $appellation';
  }
}

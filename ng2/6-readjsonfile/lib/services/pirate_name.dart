// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'dart:math' show Random;

class PirateNameService {
  static final Random indexGen = new Random();

  final String _firstName;
  final String _appellation;

  static final List<String> _names = [];
  static final List<String> _appellations = [];

  PirateNameService({String firstName, String appellation})
      : _firstName =
            firstName ?? _names[indexGen.nextInt(_names.length)],
        _appellation = appellation ??
            _appellations[indexGen.nextInt(_appellations.length)];

  String get pirateName =>
      _firstName.isEmpty ? '' : '$_firstName the $_appellation';

  String toString() => pirateName;

  static Future readyThePirates() async {
    if (_names.isNotEmpty && _appellations.isNotEmpty) {
      return;
    }
    final path = 'https://www.dartlang.org/codelabs/darrrt/files/'
        'piratenames.json';
    final jsonString = await HttpRequest.getString(path);
    final pirateNames = JSON.decode(jsonString);
    PirateNameService._names.addAll(pirateNames['names']);
    PirateNameService._appellations
        .addAll(pirateNames['appellations']);
  }
}

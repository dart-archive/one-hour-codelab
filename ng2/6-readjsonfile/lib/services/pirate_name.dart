// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'dart:math' show Random;

class PirateName {
  static final Random rng = new Random();

  final String _firstName;
  final String _appellation;

  static final List<String> _names = [];
  static final List<String> _appellations = [];

  static String randomFirstName() {
    return(_names[rng.nextInt(_names.length)]);
  }

  static String randomAppellation() {
    return(_appellations[rng.nextInt(_appellations.length)]);
  }

  PirateName({String firstName, String appellation})
      : _firstName   = firstName   ?? randomFirstName(),
        _appellation = appellation ?? randomAppellation();

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
    PirateName._names.addAll(pirateNames['names']);
    PirateName._appellations
        .addAll(pirateNames['appellations']);
  }
}
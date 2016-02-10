// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' show Random;

class PirateName {
  static final Random rng = new Random();

  final String _firstName;
  final String _appellation;

  static final List _names = [
    'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',
    'Bill', 'Ragnar', 'Ed', 'John', 'Jane' ];
  static final List _appellations = [
    'Jackal', 'King', 'Red', 'Stalwart', 'Axe',
    'Young', 'Brave', 'Eager', 'Wily', 'Zesty'];

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
}
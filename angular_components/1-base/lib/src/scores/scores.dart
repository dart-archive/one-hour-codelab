// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';

@Component(
  selector: 'scores-component',
  styleUrls: const ['scores.css'],
  templateUrl: 'scores.html',
)
class ScoresComponent {
  /// The state of cash the person would have if they saved instead of betting.
  @Input()
  int altCash;

  @Input()
  int cash;

  String get outcomeDescription {
    if (cash == altCash) return "no difference";
    double multiple = cash / altCash;
    if (cash > altCash) {
      int percentage = ((multiple - 1) * 100).round();
      return "$percentage% better";
    }
    int percentage = ((1 - multiple) * 100).round();
    return "$percentage% worse";
  }
}

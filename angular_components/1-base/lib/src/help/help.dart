// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';

@Component(
  selector: 'help-component',
  templateUrl: 'help.html',
  styleUrls: const ['help.css'],
  directives: const [
    NgSwitch,
    NgSwitchWhen,
    NgSwitchDefault,
  ],
)
class HelpComponent {
  @Input()
  String content;
}

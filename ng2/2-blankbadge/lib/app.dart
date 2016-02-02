// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'components/pirate_badge.dart';

@Component(
    selector: 'my-app',
    template: '''
    <h1>Pirate badge</h1>
    <pirate-badge></pirate-badge>
    ''',
    directives: const [PirateBadge])
class App {}

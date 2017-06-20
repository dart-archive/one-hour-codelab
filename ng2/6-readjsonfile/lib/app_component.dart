// Copyright (c) 2017, the Dart project authors.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:angular2/angular2.dart';

import 'src/badge_component.dart';

@Component(
  selector: 'my-app',
  templateUrl: 'app_component.html',
  directives: const [BadgeComponent],
)
class AppComponent {
  var name = 'Angular';
}

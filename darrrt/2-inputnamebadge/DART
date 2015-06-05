// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// In Step 2 of the code lab (dartlang.org/codelabs/darrrt/),
// you added an input field to the app.

import 'dart:html';

void main() {
  querySelector('#inputName').onInput.listen(updateBadge);
}

void updateBadge(Event e) {
  querySelector('#badgeName').text = (e.target as InputElement).value;
}

// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library piratesnest;

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:rpc/rpc.dart';

import 'package:sample/server/piratesapi.dart';

const String _API_PREFIX = '/api';
final ApiServer _apiServer =
    new ApiServer(apiPrefix: _API_PREFIX, prettyPrint: true);

main() async {
  // Add a bit of logging...
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen(print);

  // Setup a server serving the pirate api.
  _apiServer.addApi(new PiratesApi());
  HttpServer server = await HttpServer.bind(InternetAddress.ANY_IP_V4, 9090);
  server.listen(_apiServer.httpRequestHandler);

  // TODO: This should be fixed before the summit. I have a fix in mind, that
  // avoid us having to know the server url below, which can be hard to know at
  // startup given that the client could be using proxies, NATs, etc.
  var url = 'http://localhost:9090/';
  _apiServer.enableDiscoveryApi(url);
}

// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library piratesnest;

import 'dart:async';
import 'dart:io';

import 'package:http_server/http_server.dart';
import 'package:logging/logging.dart';
import 'package:rpc/rpc.dart';

import 'package:server_code_lab/server/piratesapi.dart';

final ApiServer _apiServer = new ApiServer(prettyPrint: true);

// Create a virtual directory used to serve our client code from the 'build/web'
// directory.
final String _buildPath =
    Platform.script.resolve('../build/web/').toFilePath();
final VirtualDirectory _clientDir = new VirtualDirectory(_buildPath);

main() async {
  // Add a bit of logging...
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen(print);

  // Setup a server serving the pirate api.
  _apiServer.addApi(new PiratesApi());
  HttpServer server =
      await HttpServer.bind(InternetAddress.ANY_IP_V4, 8080);
  server.listen(requestHandler);
}

Future requestHandler(HttpRequest request) async {
  if (request.uri.path.startsWith('/piratesApi')) {
    // Handle the API request.
    var apiResponse;
    try {
      var apiRequest =
          new HttpApiRequest.fromHttpRequest(request, '');
      apiResponse = await _apiServer.handleHttpApiRequest(apiRequest);
    } catch (error, stack) {
      var exception = error;
      if (exception is Error) {
        exception = new Exception(exception.toString());
      }
      apiResponse = new HttpApiResponse.error(
          HttpStatus.INTERNAL_SERVER_ERROR, exception.toString(),
          exception, stack);
    }
    return sendApiResponse(apiResponse, request.response);
  } else if (request.uri.path == '/') {
    // Redirect to the piratebadge.html file. This will initiate loading the
    // client application.
    request.response.redirect(Uri.parse('/piratebadge.html'));
  } else {
    // Disable x-frame-options SAMEORIGIN requirement. This will allow website
    // to load the client app into an iframe from a different origin.
    request.response.headers.set('X-Frame-Options', 'ALLOWALL');
    // Just serve the requested file (path) from the virtual directory,
    // minus the preceeding '/'. This will fail with a 404 Not Found if the
    // request is not for a valid file.
    var fileUri = new Uri.file(_buildPath)
        .resolve(request.uri.path.substring(1));
    _clientDir.serveFile(new File(fileUri.toFilePath()), request);
  }
}

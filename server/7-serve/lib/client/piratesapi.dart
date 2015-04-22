library server_code_lab.piratesApi.client;

import 'dart:core' as core;
import 'dart:collection' as collection;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    as commons;
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;
import 'package:server_code_lab/common/messages.dart';
export 'package:_discoveryapis_commons/_discoveryapis_commons.dart'
    show ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client piratesApi/v1';

class PiratesApi {
  final commons.ApiRequester _requester;

  PiratesApi(http.Client client,
      {core.String rootUrl: "http://localhost:8080/",
      core.String servicePath: "piratesApi/v1/"})
      : _requester = new commons.ApiRequester(
          client, rootUrl, servicePath, USER_AGENT);

  /**
   * Request parameters:
   *
   * [name] - Path parameter: 'name'.
   *
   * [appellation] - Path parameter: 'appellation'.
   *
   * Completes with a [Pirate].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<Pirate> firePirate(
      core.String name, core.String appellation) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (name == null) {
      throw new core.ArgumentError("Parameter name is required.");
    }
    if (appellation == null) {
      throw new core.ArgumentError(
          "Parameter appellation is required.");
    }

    _url = 'pirate/' +
        commons.Escaper.ecapeVariable('$name') +
        '/the/' +
        commons.Escaper.ecapeVariable('$appellation');

    var _response = _requester.request(_url, "DELETE",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => PirateFactory.fromJson(data));
  }

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Pirate].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<Pirate> hirePirate(Pirate request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode(PirateFactory.toJson(request));
    }

    _url = 'pirate';

    var _response = _requester.request(_url, "POST",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => PirateFactory.fromJson(data));
  }

  /**
   * Request parameters:
   *
   * Completes with a [core.List<Pirate>].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<core.List<Pirate>> listPirates() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    _url = 'pirates';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) =>
        data.map((value) => PirateFactory.fromJson(value)).toList());
  }

  /**
   * Request parameters:
   *
   * Completes with a [Pirate].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method  will complete with the same error.
   */
  async.Future<Pirate> shanghaiAPirate() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    _url = 'shanghai';

    var _response = _requester.request(_url, "GET",
        body: _body,
        queryParams: _queryParams,
        uploadOptions: _uploadOptions,
        uploadMedia: _uploadMedia,
        downloadOptions: _downloadOptions);
    return _response.then((data) => PirateFactory.fromJson(data));
  }
}

class PirateFactory {
  static Pirate fromJson(core.Map _json) {
    var message = new Pirate();
    if (_json.containsKey("appellation")) {
      message.appellation = _json["appellation"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    return message;
  }

  static core.Map toJson(Pirate message) {
    var _json = new core.Map();
    if (message.appellation != null) {
      _json["appellation"] = message.appellation;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    return _json;
  }
}

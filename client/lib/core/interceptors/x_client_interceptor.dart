import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

/// import convert to convert the map to json.
import 'dart:convert' as convert;

import 'package:client/core/environments/environment.dart';

/// [XClientInterceptor] is a interceptor for Client to add [X-Client-Headers] which contains [x-client-version], [x-build-number], [x-client-platform].
/// [XClientInterceptor] is a class which extends [Interceptor].
/// [XClientInterceptor] is used to add the [X-Client-Headers] to the request
class XClientInterceptor extends Interceptor {
  /// [XClientInterceptor] constructor.
  /// [XClientInterceptor] requires the [client] to be passed.
  XClientInterceptor();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var xClientHeaders = <String, dynamic>{
      'x-client-version': '1.0.0',
      'x-build-number': kMinimumBuildNumber,
    };

    if (defaultTargetPlatform == TargetPlatform.android) {
      xClientHeaders['x-client-platform'] = 'android';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      xClientHeaders['x-client-platform'] = 'ios';
    } else if (kIsWeb) {
      xClientHeaders['x-client-platform'] = 'web';
    } else if (defaultTargetPlatform == TargetPlatform.windows) {
      xClientHeaders['x-client-platform'] = 'windows';
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      xClientHeaders['x-client-platform'] = 'macos';
    } else if (defaultTargetPlatform == TargetPlatform.linux) {
      xClientHeaders['x-client-platform'] = 'linux';
    } else if (defaultTargetPlatform == TargetPlatform.fuchsia) {
      xClientHeaders['x-client-platform'] = 'fuchsia';
    } else {
      xClientHeaders['x-client-platform'] = 'unknown';
    }

    /// platform is platform of the client.
    /// version is version of the client.
    options.headers = {
      ...options.headers,
      'x-client-headers': convert.jsonEncode(xClientHeaders),
    };
    return handler.next(options);
  }
}

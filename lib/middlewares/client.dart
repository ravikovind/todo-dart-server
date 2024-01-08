import 'package:shelf/shelf.dart';
import 'dart:convert' as convert;
import '../core/extenstions.dart';

/// [xClient] is a middleware that will be called before every action
/// is dispatched. It will check if the client is send a request header with a accepted value.
/// If the value is not accepted, it will return a 401 response.
/// If the value is accepted, it will continue to the next middleware.

Middleware xClient() => (Handler innerHandler) => (Request request) async {
      final client = request.headers['x-client-header'];
      if (client == null) {
        return Response(401).json({
          'message': 'You are not authorized client!',
        });
      }
      final decode = Map<String, dynamic>.from(
          convert.jsonDecode(client)?['x-client-header']);
      final buildNumber = decode['x-build-number']?.toString();
      final version = decode['x-client-version']?.toString();
      final platform = decode['x-client-platform']?.toString();
      if (buildNumber == null || version == null || platform == null) {
        return Response(401).json({
          'message': 'Unauthorized Client!',
        });
      }
      return innerHandler(request.change(
        headers: {
          'x-build-number': buildNumber,
          'x-client-version': version,
          'x-client-platform': platform,
        },
      ));
    };

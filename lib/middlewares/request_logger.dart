import 'package:shelf/shelf.dart';
import 'package:stack_trace/stack_trace.dart';

import '../core/extenstions.dart';

/// [requestLogger] is a [Middleware] that logs the requests.
/// It will log the request method, the request path, the request query, the request status code,
/// and the request duration.
Middleware requestLogger() => (innerHandler) => (request) {
      var startTime = DateTime.now();
      var watch = Stopwatch()..start();
      return Future.sync(() => innerHandler(request)).then((response) {
        final message = _message(
          startTime,
          response.statusCode,
          request.requestedUri,
          request.method,
          watch.elapsed,
        );
        print('REQUEST: $message');
        return response;
      }, onError: (Object error, StackTrace stackTrace) {
        if (error is HijackException) throw error;
        final message = _errorMessages(
          startTime,
          request.requestedUri,
          request.method,
          watch.elapsed,
          error,
          stackTrace,
        );
        print('ERROR: ${message.$1}');
        return Response.internalServerError().json({
          'message': message.$2,
        });
      });
    };

String _formatQuery(String query) => query.isEmpty ? '' : '?$query';

String _message(
  DateTime requestTime,
  int statusCode,
  Uri requestedUri,
  String method,
  Duration elapsedTime,
) {
  if (statusCode >= 200 && statusCode < 300) {
    return '\x1b[33m[${requestTime.toIso8601String()}] '
        '${elapsedTime.toString().padLeft(15)} '
        '${method.padRight(7)} [$statusCode] '
        '${requestedUri.path}${_formatQuery(requestedUri.query)}\x1b[0m';
  } else if (statusCode >= 300 && statusCode < 400) {
    return '\x1b[32m[${requestTime.toIso8601String()}] '
        '${elapsedTime.toString().padLeft(15)} '
        '${method.padRight(7)} [$statusCode] '
        '${requestedUri.path}${_formatQuery(requestedUri.query)}\x1b[0m';
  }
  return '\x1b[31m[${requestTime.toIso8601String()}] '
      '${elapsedTime.toString().padLeft(15)} '
      '${method.padRight(7)} [$statusCode] '
      '${requestedUri.path}${_formatQuery(requestedUri.query)}\x1b[0m';
}

(String, String) _errorMessages(DateTime requestTime, Uri requestedUri,
    String method, Duration elapsedTime, Object error, StackTrace? stack) {
  final message = '[${requestTime.toIso8601String()}] '
      '${elapsedTime.toString().padLeft(15)} '
      '${method.padRight(7)} '
      '${requestedUri.path}${_formatQuery(requestedUri.query)} '
      '${error.toString()}';
  if (stack == null) return ('/x1b[31m$message\x1b[0m', '$error');
  final chain = Chain.forTrace(stack)
      .foldFrames((frame) =>
          frame.isCore ||
          frame.package == 'shelf' ||
          frame.package == 'dart_frog')
      .terse;
  return (
    '\x1b[31m$message\x1b[0m'
        '\n\x1b[31m$chain\x1b[0m',
    '$error '
        'at '
        '$chain',
  );
}

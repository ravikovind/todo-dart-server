import 'package:dio/dio.dart';

/// [DioExceptionOf] is class for handling [Dio] exceptions type [DioException].
/// [DioExceptionOf] implements [Exception].

class DioExceptionOf implements Exception {
  /// [message] is the error message. it is a [String].
  var message = 'Oops! something went wrong.';

  /// [DioExceptionOf.exceptionFromError] is a factory constructor.
  /// It is a factory constructor.
  /// it accepts [DioException] as a parameter.
  /// It returns [DioExceptionOf] instance.
  DioExceptionOf.exceptionFromError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        message = 'Request to the server was cancelled.';
        break;
      case DioExceptionType.connectionTimeout:
        message = 'Connection timed out.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receiving timeout occurred.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Request send timeout.';
        break;
      case DioExceptionType.badResponse:
        message = _statusCodeToError(error);
        break;
      case DioExceptionType.unknown:
        if (error.message?.contains('SocketException') == true ||
            error.message?.contains('HandshakeException') == true) {
          message = 'No Internet, Please try again.';
          break;
        }
        break;
      default:
        break;
    }
  }

  /// [_statusCodeToError] is a private method.
  /// It is used to handle [Dio] status codes.
  String _statusCodeToError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;
    if (data is String || data is! Map<String, dynamic>) {
      return 'Oops! something went wrong. it\'s not you, it\'s us. we are working on it. it will be fixed within 1 minute. please try again.';
    }

    final message = data['message']?.toString();
    if (message != null && message.isNotEmpty) {
      return message;
    }
    switch (statusCode) {
      case 400:
        return 'Bad Request.';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'unexpected error occurred. we are working on it. it will be fixed. please try again.';
      default:
        return 'Oops! something went wrong. it\'s not you, it\'s us. we are working on it. it will be fixed within 1 minute. please try again.';
    }
  }
}

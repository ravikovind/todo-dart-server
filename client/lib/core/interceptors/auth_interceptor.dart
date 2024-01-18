import 'package:dio/dio.dart';
import 'package:client/core/utils/constants.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:string_contains/string_contains.dart';

/// [AuthInterceptor] is a [Interceptor] that adds the authorization header to the request.
/// [AuthInterceptor] is used to add the authorization header to the request

class AuthInterceptor extends Interceptor {
  /// [AuthInterceptor] constructor.
  AuthInterceptor();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final accessToken = HydratedBloc.storage.read(kToken)?.toString();
    if (accessToken.isNullOrEmpty) {
      return handler.next(options);
    }
    options.headers = {
      ...options.headers,
      'Authorization': 'Bearer $accessToken',
    };
    return handler.next(options);
  }
}

import 'package:dio/dio.dart';
import 'package:client/core/exceptions/dio_exception.dart';
import 'package:client/core/interceptors/x_client_interceptor.dart';
import 'package:client/core/utils/constants.dart';
import 'package:client/data/models/json_response.dart';
import 'package:client/data/models/user.dart';

/// [AuthService] is a class that handles all the authentication related operations.
/// [dio] is an instance of [Dio] class. It is used to make HTTP requests.

class AuthService {
  /// [AuthService] constructor
  AuthService({required this.dio}) {
    dio.options.baseUrl = '$kURL$kUserPath';
    dio.options.sendTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.responseType = ResponseType.json;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    dio.interceptors.add(XClientInterceptor());
  }

  /// [dio] is an instance of [Dio] class. It is used to make HTTP requests.
  final Dio dio;

  /// [signUp] is a method that sends a POST request to the server to register a user.
  Future<JsonResponse> signUp({
    required User user,
  }) async {
    try {
      final Response response = await dio.post(kSignUpPath, data: {
        ...user.entity,
      });
      if (response.statusCode == 201) {
        final user = User.fromJson(response.data ?? <String, dynamic>{});
        return JsonResponse.success(
          data: user,
          message: 'User registered successfully.',
        );
      } else {
        final message = response.data?['message']?.toString();
        return JsonResponse.failure(
          message: message ?? 'Something went wrong. Please try again later.',
        );
      }
    } on DioException catch (e) {
      final message = DioExceptionOf.exceptionFromError(e).message;
      return JsonResponse.failure(
        message: message,
      );
    } catch (e) {
      return JsonResponse.failure(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  /// signIn is a method that sends a POST request to the server to authenticate a user.
  /// It returns a [JsonResponse] object.

  Future<JsonResponse> signIn({
    required User user,
  }) async {
    try {
      final Response response = await dio.post(
        kSignInPath,
        data: {
          ...user.entity,
        },
      );
      if (response.statusCode == 200) {
        final user = User.fromJson(response.data ?? <String, dynamic>{});
        return JsonResponse.success(
          message: 'Signed in successfully.',
          data: user,
        );
      } else {
        final message = response.data?['message']?.toString();
        return JsonResponse.failure(
          message: message ?? 'Something went wrong. Please try again later.',
        );
      }
    } on DioException catch (e) {
      final message = DioExceptionOf.exceptionFromError(e).message;
      return JsonResponse.failure(
        message: message,
      );
    } catch (e) {
      return JsonResponse.failure(
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

}

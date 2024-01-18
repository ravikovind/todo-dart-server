import 'package:client/data/models/json_response.dart';
import 'package:client/data/models/user.dart';
import 'package:client/data/services/auth_service.dart';

abstract class AuthRepository {
  Future<JsonResponse> signIn({
    required User user,
  });
  Future<JsonResponse> signUp({
    required User user,
  });
}

class AuthRepositoryOf implements AuthRepository {
  AuthRepositoryOf({required this.service});
  final AuthService service;

  @override
  Future<JsonResponse> signIn({
    required User user,
  }) =>
      service.signIn(
        user: user,
      );

  @override
  Future<JsonResponse> signUp({
    required User user,
  }) =>
      service.signUp(
        user: user,
      );

}

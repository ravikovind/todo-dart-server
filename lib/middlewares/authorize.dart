import 'package:shelf/shelf.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import '../app/error/server_exception.dart';
import '../env/env.dart';

/// [authorize] is a middleware that will be called before every action of authenticated user
/// it will check if the user is authenticated or not
/// if the user is authenticated, it will add the user to the request context
/// else it will return the request as it is
Middleware authorize() => (Handler innerHandler) => (Request request) async {
      try {
        final authorization = request.headers['Authorization']?.toString();
        if (authorization == null) {
          throw ServerException('Unauthorized Request');
        }
        final token = authorization.split(' ').last;
        final jwt = JWT.verify(token, SecretKey(Env.secret));
        final user = jwt.payload['user']?.toString();
        if (user == null) throw ServerException('Unauthorized User');
        return innerHandler(request.change(context: {'user': user}));
      } on Exception catch (_) {
        return innerHandler(request);
      }
    };

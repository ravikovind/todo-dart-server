import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'db')
  static const String db = _Env.db;
  @EnviedField(varName: 'secret')
  static const String secret = _Env.secret;
  @EnviedField(varName: 'salt')
  static const String salt = _Env.salt;
}

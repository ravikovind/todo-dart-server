import 'package:shelf_router/shelf_router.dart';
import '../controllers/auth.dart';

/// [authRouter] is a [Router] for the auth routes.
final authRouter = Router()
  ..post('/sign-in', signIn)
  ..post('/sign-up', signUp);

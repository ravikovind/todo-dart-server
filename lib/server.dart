import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'app/routes/auth.dart';
import 'app/routes/todo.dart';
import 'config/mongoose.dart';
import 'core/extenstions.dart';
import 'env/env.dart';
import 'middlewares/authorize.dart';
import 'middlewares/client.dart';
import 'middlewares/request_logger.dart';

/// [_router] is the top-level request handler.
final _router = Router()
  ..get('/', _rootHandler)
  ..mount('/api/v1/todos', todoRouter)
  ..mount('/api/v1/auth', authRouter)
  ..all('/<ignored|.*>', _notFoundHandler);

/// [_rootHandler] request handler for the root path.
Response _rootHandler(Request request) => Response(200).json({
      'message': 'Hey Buddy, Server is up and running.',
    });

/// [_notFoundHandler] request handler for the not found path.
Response _notFoundHandler(Request request) => Response(404).json({
      'message': 'Are you lost buddy?',
    });

/// [Server] class is the entry point of the server.
class Server {
  /// [start] starts the server.
  static Future<void> start() async {
    try {
      final ip = InternetAddress.loopbackIPv4;
      final handler = Pipeline()
          .addMiddleware(requestLogger())
          .addMiddleware(xClient())
          .addMiddleware(authorize())
          .addHandler(_router);
      await Mongoose.open(Env.db)
          .then((value) => print('database connected successfully'));
      final port = int.tryParse('${Platform.environment['PORT']}') ?? 8080;
      final server = await serve(handler, ip, port);
      print('server listening on ${server.address.host}:${server.port}');
    } on Exception catch (_) {
      throw Exception('There is an error while running the server!');
    }
  }
}

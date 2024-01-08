import 'package:shelf_router/shelf_router.dart';
import '../controllers/todo.dart';


/// [todoRouter] is a [Router] for the todo routes.
final todoRouter = Router()
  ..post('/create', create)
  ..get('/all', todos)
  ..get('/<todo>', todo)
  ..put('/<todo>', update)
  ..delete('/<todo>', delete);

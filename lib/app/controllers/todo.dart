import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../core/extenstions.dart';
import '../error/server_exception.dart';
import '../models/todo.dart';
import '../models/user.dart';

/// [create] creates a new todo.
Future<Response> create(Request request) async {
  try {
    final user = User(id: request.context['user']?.toString());
    if (user.id == null) {
      throw ServerException('Unauthorized Request');
    }
    final userOf = await user.scheme?.findOne({
      '_id': user.id.object,
    });
    if (userOf == null) {
      throw ServerException('Unauthorized Request');
    }

    final body = await request.body;
    final todo = TODO.fromJson(body);

    if (todo.title == null) {
      throw ServerException('Title is required!');
    }

    final result = await todo.scheme?.insert({
      ...todo
          .copyWith(
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          )
          .toJson(),

      /// insert user id as a reference
      'user': user.id.object,
    });
    if (result == null) {
      return Response.internalServerError().json(
        {'message': 'Something went wrong!'},
      );
    }
    return Response(200).json(result);
  } on Exception catch (e) {
    return Response.internalServerError().json({'message': e.toString()});
  }
}

/// [todo] returns a todo. with the given id.
Future<Response> todo(Request request) async {
  try {
    final user = User(id: request.context['user']?.toString());
    final todo = TODO(
      id: request.params['todo']?.toString(),
      user: user.id,
    );
    if (user.id == null) {
      throw ServerException('Unauthorized Request');
    }
    final userOf = await user.scheme?.findOne({
      '_id': user.id.object,
    });
    if (userOf == null) {
      throw ServerException('Unauthorized Request');
    }

    final todoOf = await todo.scheme?.findOne({
      '_id': todo.id.object,
      'user': user.id.object,
    });

    if (todoOf == null) {
      throw ServerException('Todo is deleted or not found!');
    }
    return Response(200).json(todoOf);
  } on Exception catch (e) {
    return Response.internalServerError().json({'message': e.toString()});
  }
}

/// [todos] returns all todos.
Future<Response> todos(Request request) async {
  try {
    final user = User(id: request.context['user']?.toString());
    if (user.id == null) {
      throw ServerException('Unauthorized Request');
    }
    final userOf = await user.scheme?.findOne({
      '_id': user.id.object,
    });
    if (userOf == null) {
      throw ServerException('Unauthorized Request');
    }

    final todos = await TODO().scheme?.find({
      'user': user.id.object,
    }).toList();

    if (todos == null) {
      return Response.internalServerError().json(
        {'message': 'Something went wrong!'},
      );
    }
    return Response(200).json(todos);
  } on Exception catch (e) {
    return Response.internalServerError().json({'message': e.toString()});
  }
}

/// [update] updates a todo.
Future<Response> update(Request request) async {
  try {
    final user = User(id: request.context['user']?.toString());
    final todo = TODO(
      id: request.params['todo']?.toString(),
      user: user.id,
    );
    if (user.id == null) {
      throw ServerException('Unauthorized Request');
    }
    final userOf = await user.scheme?.findOne({
      '_id': user.id.object,
    });
    if (userOf == null) {
      throw ServerException('Unauthorized Request');
    }

    final todoOf = await todo.scheme?.findOne({
      '_id': todo.id.object,
      'user': user.id.object,
    });

    if (todoOf == null) {
      throw ServerException('Todo is deleted or not found!');
    }

    final body = await request.body;
    final updatedTodo = TODO.fromJson(body);

    final result = await todo.scheme?.update(
      {
        '_id': todo.id.object,
        'user': user.id.object,
      },
      {
        ...todo
            .copyWith(
              title: updatedTodo.title,
              description: updatedTodo.description,
              completed: updatedTodo.completed,
              updatedAt: DateTime.now(),
            )
            .toJson()
          ..removeWhere((key, value) => value == null),
        'user': user.id.object,
      },
    );

    if (result == null) {
      return Response.internalServerError().json(
        {'message': 'Something went wrong!'},
      );
    }
    return Response(200).json({'message': 'Todo updated successfully!'});
  } on Exception catch (e) {
    return Response.internalServerError().json({'message': e.toString()});
  }
}

/// [delete] deletes a todo.
Future<Response> delete(Request request) async {
  try {
    final user = User(id: request.context['user']?.toString());
    final todo = TODO(
      id: request.params['todo']?.toString(),
      user: user.id,
    );
    if (user.id == null) {
      throw ServerException('Unauthorized Request');
    }
    final userOf = await user.scheme?.findOne({
      '_id': user.id.object,
    });
    if (userOf == null) {
      throw ServerException('Unauthorized Request');
    }

    final todoOf = await todo.scheme?.findOne({
      '_id': todo.id.object,
      'user': user.id.object,
    });

    if (todoOf == null) {
      throw ServerException('Todo is deleted or not found!');
    }

    final result = await todo.scheme?.remove({
      '_id': todo.id.object,
      'user': user.id.object,
    });

    if (result == null) {
      return Response.internalServerError().json(
        {'message': 'Something went wrong!'},
      );
    }
    return Response(200).json({'message': 'Todo deleted successfully!'});
  } on Exception catch (e) {
    return Response.internalServerError().json({'message': e.toString()});
  }
}

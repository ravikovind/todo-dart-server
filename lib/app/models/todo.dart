import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../config/mongoose.dart';

/// [TODO] is a model class that represents a todo.
class TODO extends Equatable {
  TODO({
    this.id,
    this.title,
    this.description,
    this.completed = false,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  /// [id] is the unique identifier for the todo.
  final String? id;

  /// [title] is the title of the todo.
  final String? title;

  /// [description] is the description of the todo.
  final String? description;

  /// [completed] is the completion status of the todo.
  final bool? completed;

  /// [user] is the user id of the todo.
  final String? user;

  /// [createdAt] is the date and time the todo was created.
  final DateTime? createdAt;

  /// [updatedAt] is the date and time the todo was updated.
  final DateTime? updatedAt;

  /// [fromJson] converts a json object to a [TODO] instance.
  factory TODO.fromJson(Map<String, dynamic> json) => TODO(
        id: json['todo']?.toString(),
        title: json['title']?.toString(),
        description: json['description']?.toString(),
        completed: bool.tryParse('${json['completed']}') ?? false,
        user: json['user']?.toString(),
      );

  /// [toJson] converts a [TODO] instance to a json object.
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'completed': completed,
        'createdAt': DateTime.now().toUtc().toIso8601String(),
        'updatedAt': DateTime.now().toUtc().toIso8601String(),
      };

  /// [copyWith] creates a copy of the [TODO] with the specified attributes.
  TODO copyWith({
    String? title,
    String? description,
    bool? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TODO(
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        completed,
        user,
        createdAt,
        updatedAt,
      ];
}

/// [OfTODO] is an extension class that adds functionality to the [TODO] model.
extension OfTODO on TODO {
  /// [scheme] is the mongodb collection for the [TODO] model.
  mongo.DbCollection? get scheme => Mongoose.db?.collection('todos');
}

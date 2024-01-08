import 'package:equatable/equatable.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import '../../config/mongoose.dart';

/// [User] is a model class that represents a user.
class User extends Equatable {
  /// [User] constructor.
  const User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.verified = false,
    this.createdAt,
    this.updatedAt,
  });

  /// [id] is the unique identifier for the user.
  final String? id;

  /// [name] is the name of the user.
  final String? name;

  /// [email] is the email of the user.
  final String? email;

  /// [password] is the password of the user.
  final String? password;

  /// [verified] is the verification status of the user.
  final bool? verified;

  /// [createdAt] is the date and time the user was created.
  final DateTime? createdAt;

  /// [updatedAt] is the date and time the user was updated.
  final DateTime? updatedAt;

  /// [User.fromJson] creates a [User] from a json map.
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['user']?.toString(),
        name: json['name']?.toString(),
        email: json['email']?.toString(),
        password: json['password']?.toString(),
        createdAt: DateTime.tryParse('${json['createdAt']}'),
        updatedAt: DateTime.tryParse('${json['updatedAt']}'),
      );

  /// [toJson] converts a [User] to a json map.
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'verified': verified,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  /// [copyWith] creates a copy of the [User] with the specified attributes.
  User copyWith({
    String? name,
    String? email,
    String? password,
    bool? verified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      verified: verified ?? this.verified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        verified,
        createdAt,
        updatedAt,
      ];
}

/// [OfUser] is an extension class that adds functionality to the [User] class.
extension OfUser on User {
  /// [scheme] returns the table schema for the model.
  mongo.DbCollection? get scheme => Mongoose.db?.collection('users');
}

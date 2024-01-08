import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:crypto/crypto.dart';

import '../../core/extenstions.dart';
import '../../env/env.dart';
import '../error/server_exception.dart';
import '../models/user.dart';

/// [signUp] creates a new user.

Future<Response> signUp(Request request) async {
  try {
    final body = await request.body;

    /// [name], [email] and [password] are required
    final name = body['name']?.toString();
    final email = body['email']?.toString();
    final password = body['password']?.toString();
    if (name == null || email == null || password == null) {
      throw ServerException('Name, Email or Password is incorrect');
    }

    /// user instance
    final user = User();

    /// find user by email
    final userOf = await user.scheme?.findOne({'email': email});
    if (userOf != null) {
      throw ServerException('Account already exists with this email!');
    }

    /// hash password
    final key = utf8.encode(Env.salt);
    final bytes = utf8.encode(password);
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);

    /// create user
    final result = await user.scheme?.insertOne(user
        .copyWith(
          name: name,
          email: email,
          password: digest.toString(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )
        .toJson());
    if (result == null || result.document == null) {
      throw ServerException('There was an error creating your account!');
    }

    final document = Map<String, dynamic>.from(result.document ?? {});

    /// create jwt token
    final jwt = JWT(
      {
        'user': document['_id']?.toString().oid,
        'iat': DateTime.now().millisecondsSinceEpoch,
        'exp': DateTime.now().add(Duration(days: 7)).millisecondsSinceEpoch,
      },
      subject: email,
    );

    /// sign jwt token
    final token = jwt.sign(SecretKey(Env.secret));
    document['token'] = token;
    return Response(201).json(document);
  } on Exception catch (_) {
    return Response(400).json({
      'message': _.toString(),
    });
  }
}

/// [signIn] signs in a user.
Future<Response> signIn(Request request) async {
  try {
    final body = await request.body;

    /// [email] and [password] are required
    final email = body['email']?.toString();
    final password = body['password']?.toString();
    if (email == null || password == null) {
      throw ServerException('Email or Password is incorrect');
    }

    /// user instance
    final user = User();

    /// find user by email
    final document = await user.scheme?.findOne({'email': email});
    if (document == null) {
      throw ServerException('No Account Associated with this email!');
    }
    final hashedPassword = document['password']?.toString();
    final emailOf = document['email']?.toString();
    if (emailOf == null || hashedPassword == null) {
      throw ServerException('No Account Associated with this email!');
    }

    /// compare password
    final key = utf8.encode(Env.salt);
    final bytes = utf8.encode(password);
    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);
    if (digest.toString() != hashedPassword) {
      throw ServerException('Password is incorrect');
    }

    /// create jwt token
    final jwt = JWT(
      {
        'user': document['_id']?.toString().oid,
        'iat': DateTime.now().millisecondsSinceEpoch,
        'exp': DateTime.now().add(Duration(days: 7)).millisecondsSinceEpoch,
      },
      subject: document['email']?.toString(),
    );

    /// sign jwt token
    final token = jwt.sign(SecretKey(Env.secret));
    document['token'] = token;

    return Response(200).json(document);
  } on Exception catch (_) {
    return Response(401).json({
      'message': _.toString(),
    });
  }
}

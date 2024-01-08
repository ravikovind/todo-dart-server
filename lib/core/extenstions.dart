import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'dart:convert' as convert;

/// [OfResponse] extends the [Response] class.
extension OfResponse on Response {
  /// [json] returns a [Response] with the specified json body.
  Response json(json) {
    if (json is! Map<String, dynamic> && json is! List<Map<String, dynamic>>) {
      throw Exception('Unprocessable Entity');
    }
    return Response(
      statusCode,
      body: convert.jsonEncode(json),
      headers: {
        'content-type': 'application/json',
        ...headers,
      },
      encoding: encoding,
      context: context,
    );
  }
}

/// [OfRequest] extends the [Request] class.
extension OfRequest on Request {
  /// [body] returns the body of the request as a json map.
  Future<Map<String, dynamic>> get body async {
    final body = await readAsString();
    return convert.jsonDecode(body);
  }
}

/// [OfNullableString] is extension methods on nullable [String].
extension OfNullableString on String? {
  /// [value] returns the value of the string or an empty string.
  String get value => this ?? '';

  /// [oid] returns the object id of the string.
  ///
  /// Example:
  /// ```dart
  /// final id = 'ObjectId("5f9b3b3b3b3b3b3b3b3b3b3b")';
  /// print(id.oid); // 5f9b3b3b3b3b3b3b3b3b3b3b
  ///
  /// final id = '5f9b3b3b3b3b3b3b3b3b3b3b';
  /// print(id.oid); // 5f9b3b3b3b3b3b3b3b3b3b3b
  /// ```
  String get oid {
    try {
      if (value.isEmpty) return value;
      final oid = RegExp(r'ObjectId\("(.*)"\)').firstMatch(value)?.group(1);
      if (oid == null) return value;
      return oid;
    } on Exception catch (_) {
      return value;
    }
  }

  /// [object] returns the [ObjectId] of the string.
  ///
  /// Example:
  /// ```dart
  /// final id = "5f9b3b3b3b3b3b3b3b3b3b3b";
  /// print(id.object); // ObjectId("5f9b3b3b3b3b3b3b3b3b3b3b")
  /// ```
  ObjectId get object {
    try {
      return ObjectId.fromHexString(oid);
    } on Exception catch (_) {
      throw Exception('Unprocessable Entity');
    }
  }
}

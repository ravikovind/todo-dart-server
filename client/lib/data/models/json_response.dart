import 'package:equatable/equatable.dart';

/// [JsonResponse] is a class that contains the responses of server.
/// It contains the [data] and [message] of the response.
/// It contains the [statusCode] of the response.
/// It contains the [success] of the response.
/// it is very helpful exchanging data between the server and the client.
class JsonResponse extends Equatable {
  /// [JsonResponse] constructor.
  const JsonResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
  });

  /// [success] is the success of the response.
  /// It is true if the response is successful.
  /// It is false if the response is not successful.
  final bool success;

  /// [statusCode] is the status code of the response.
  /// It is the status code of the response.
  final int statusCode;

  /// [message] is the message for the response.
  /// It is the message for the response.
  final String message;

  /// [data] is the data of the response.
  /// It is the data of the response.
  final Object? data;

  /// [JsonResponse.success] returns a [JsonResponse] with [success] set to true and [statusCode] set to 200.
  factory JsonResponse.success({String message = 'success', Object? data}) =>
      JsonResponse(
        success: true,
        statusCode: 200,
        message: message,
        data: data,
      );

  /// [JsonResponse.created] returns a [JsonResponse] with [success] set to true and [statusCode] set to 201.
  factory JsonResponse.created({String message = 'success', Object? data}) =>
      JsonResponse(
        success: true,
        statusCode: 201,
        message: message,
        data: data,
      );

  /// [JsonResponse.failure] returns a [JsonResponse] with [success] set to false and [statusCode] set to the provided [statusCode].
  /// [message] is set to the provided [message].
  factory JsonResponse.failure({
    int statusCode = 500,
    String message = 'failure',
    Object? data,
  }) =>
      JsonResponse(
        success: false,
        statusCode: statusCode,
        message: message,
        data: data,
      );

  /// [JsonResponse.unauthorized] returns a [JsonResponse] with [success] set to false and [statusCode] set to 401.
  /// [message] is set to the provided [message].
  /// [data] is set to the provided [data].

  factory JsonResponse.unauthorized({
    String message = 'unauthorized',
    Object? data,
  }) =>
      JsonResponse(
        success: false,
        statusCode: 401,
        message: message,
        data: data,
      );

  /// [JsonResponse.copyWith] returns a [JsonResponse] with the provided [success], [statusCode], [message] and [data].
  /// [success] is optional.
  /// [statusCode] is optional.
  /// [message] is optional.
  /// [data] is optional.
  JsonResponse copyWith({
    bool? success,
    int? statusCode,
    String? message,
    Object? data,
  }) =>
      JsonResponse(
        success: success ?? this.success,
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  /// [fromJson] method converts a [Map<String, dynamic>] into a [JsonResponse] instance.
  /// It is used to convert a JSON object received from the server into a [JsonResponse] instance.
  /// It returns a [JsonResponse] instance.

  factory JsonResponse.fromJson(Map<String, dynamic> json) => JsonResponse(
        success: json['success']?.toString() == 'true',
        statusCode: int.tryParse('${json['statusCode']}') ?? 500,
        message: json['message']?.toString() ?? 'failure',
        data: json['data'],
      );

  /// [toJson] method converts a [JsonResponse] instance into a [Map<String, dynamic>].
  /// It is used to convert a [JsonResponse] instance into a JSON object to send to the server.
  /// It returns a [Map<String, dynamic>].

  Map<String, dynamic> toJson() => {
        'success': success,
        'statusCode': statusCode,
        'message': message,
        'data': data,
      };

  /// entity method returns the [data] of the [JsonResponse] instance.
  /// It returns the [data] of the [JsonResponse] instance.

  Map<String, dynamic> get entity => toJson()
    ..removeWhere(
      (_, v) => v == null,
    );

  @override
  List<Object?> get props => [success, statusCode, message, data];

  @override
  String toString() => '${toJson()}';
}

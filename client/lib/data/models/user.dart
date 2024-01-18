import 'package:equatable/equatable.dart';

/// [User] is a model class that represents a user.
class User extends Equatable {
  /// [User] constructor.
  const User({
    this.id,
    this.name,
    this.gender,
    this.dateOfBirth,
    this.phone,
    this.email,
    this.password,
    this.status,
    this.provider,
    this.verified,
    this.verifiedAt,
    this.accessToken,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? phone;
  final String? email;
  final String? password;
  final String? status;
  final String? provider;
  final bool? verified;
  final DateTime? verifiedAt;
  final String? accessToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// [fromJson] method converts a [Map<String, dynamic>] into a [User] instance.
  /// It is used to convert a JSON object received from the server into a [User] instance.
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id']?.toString(),
        name: json['name']?.toString(),
        gender: json['gender']?.toString(),
        dateOfBirth: DateTime.tryParse('${json['dateOfBirth']}'),
        phone: json['phone']?.toString(),
        email: json['email']?.toString(),
        password: json['password']?.toString(),
        status: json['status']?.toString(),
        provider: json['provider']?.toString(),
        verified: json['verified']?.toString() == 'true',
        verifiedAt: DateTime.tryParse('${json['verifiedAt']}'),
        accessToken: json['accessToken']?.toString(),
        createdAt: DateTime.tryParse('${json['createdAt']}'),
        updatedAt: DateTime.tryParse('${json['updatedAt']}'),
      );

  /// [toJson] method converts a [User] instance into a [Map<String, dynamic>].
  /// It is used to convert a [User] instance into a JSON object to send to the server.

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'gender': gender,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'phone': phone,
        'email': email,
        'password': password,
        'status': status,
        'provider': provider,
        'verifeid': verified,
        'verifeidAt': verifiedAt?.toIso8601String(),
        'accessToken': accessToken,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };

  Map<String, dynamic> get entity => {
        'name': name,
        'gender': gender,
        'dateOfBirth': dateOfBirth?.toIso8601String(),
        'phone': phone,
        'email': email,
        'password': password,
        'status': status,
        'provider': provider,
        'verifeid': verified,
        'verifeidAt': verifiedAt?.toIso8601String(),
      }..removeWhere((_, v) => v == null);

  /// copyWith method is used to create a copy of the [User] instance,
  /// while replacing some of its properties.
  User copyWith({
    String? name,
    String? gender,
    DateTime? dateOfBirth,
    String? phone,
    String? email,
    String? password,
    String? status,
    String? provider,
    bool? verified,
    DateTime? verifiedAt,
    String? accessToken,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        name: name ?? this.name,
        gender: gender ?? this.gender,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        provider: provider ?? this.provider,
        verified: verified ?? this.verified,
        verifiedAt: verifiedAt ?? this.verifiedAt,
        accessToken: accessToken ?? this.accessToken,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        gender,
        dateOfBirth,
        email,
        password,
        status,
        provider,
        verified,
        verifiedAt,
        accessToken,
        createdAt,
        updatedAt,
      ];
}

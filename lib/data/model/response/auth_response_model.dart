import 'package:meta/meta.dart';
import 'dart:convert';

class AuthResponseModel {
  final String message;
  final String accessToken;
  final User user;

  AuthResponseModel({
    required this.message,
    required this.accessToken,
    required this.user,
  });

  AuthResponseModel copyWith({
    String? message,
    String? accessToken,
    User? user,
  }) =>
      AuthResponseModel(
        message: message ?? this.message,
        accessToken: accessToken ?? this.accessToken,
        user: user ?? this.user,
      );

  factory AuthResponseModel.fromJson(String str) => AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) => AuthResponseModel(
    message: json["message"],
    accessToken: json["access_token"],
    user: User.fromMap(json["user"]),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "access_token": accessToken,
    "user": user.toMap(),
  };
}

class User {
  final int id;
  final String name;
  final String email;
  final DateTime emailVerifiedAt;
  final dynamic twoFactorSecret;
  final dynamic twoFactorRecoveryCodes;
  final dynamic twoFactorConfirmedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.twoFactorSecret,
    required this.twoFactorRecoveryCodes,
    required this.twoFactorConfirmedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    DateTime? emailVerifiedAt,
    dynamic twoFactorSecret,
    dynamic twoFactorRecoveryCodes,
    dynamic twoFactorConfirmedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        twoFactorSecret: twoFactorSecret ?? this.twoFactorSecret,
        twoFactorRecoveryCodes: twoFactorRecoveryCodes ?? this.twoFactorRecoveryCodes,
        twoFactorConfirmedAt: twoFactorConfirmedAt ?? this.twoFactorConfirmedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    twoFactorSecret: json["two_factor_secret"],
    twoFactorRecoveryCodes: json["two_factor_recovery_codes"],
    twoFactorConfirmedAt: json["two_factor_confirmed_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "two_factor_secret": twoFactorSecret,
    "two_factor_recovery_codes": twoFactorRecoveryCodes,
    "two_factor_confirmed_at": twoFactorConfirmedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

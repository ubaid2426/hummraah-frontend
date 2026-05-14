// data/models/user_model.dart
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String email,
    required String fullName,
    String? accessToken,
    String? refreshToken,
    String? message,
  }) : super(
          email: email,
          fullName: fullName,
          accessToken: accessToken,
          refreshToken: refreshToken,
          message: message,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? json['name'] ?? '',
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'message': message,
    };
  }
}
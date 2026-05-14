// domain/entities/user.dart
class User {
  final String email;
  final String fullName;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  User({
    required this.email,
    required this.fullName,
    this.accessToken,
    this.refreshToken,
    this.message,
  });
}
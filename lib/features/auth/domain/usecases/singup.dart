// domain/usecases/signup.dart
import 'package:dartz/dartz.dart';
import 'package:hummraah/core/error/failures.dart';
// import '../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Signup {
  final AuthRepository repository;

  Signup(this.repository);

  Future<Either<Failure, User>> call(SignupParams params) async {
    return await repository.signup(params.toJson());
  }
}

class SignupParams {
  final String fullName;
  final String email;
  final String mobileNumber;
  final String password;
  final String address;
  final String emergencyNumber;
  final String country;
  final String cnic;
  final String passportNumber;
  final String passportExpiryDate;

  SignupParams({
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.address,
    required this.emergencyNumber,
    required this.country,
    required this.cnic,
    required this.passportNumber,
    required this.passportExpiryDate,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'mobileNumber': mobileNumber,
    'password': password,
    'address': address,
    'emergencyNumber': emergencyNumber,
    'country': country,
    'cnic': cnic,
    'passportNumber': passportNumber,
    'passportExpiryDate': passportExpiryDate,
  };
}
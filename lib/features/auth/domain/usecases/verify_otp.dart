// domain/usecases/verify_otp.dart
import 'package:dartz/dartz.dart';
import 'package:hummraah/core/error/failures.dart';
// import '../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class VerifyOtp {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  Future<Either<Failure, User>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(params.email, params.otp);
  }
}

class VerifyOtpParams {
  final String email;
  final String otp;
  
  VerifyOtpParams({required this.email, required this.otp});
}
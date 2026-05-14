// domain/usecases/send_otp.dart
import 'package:dartz/dartz.dart';
import 'package:hummraah/core/error/failures.dart';
// import '../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class SendOtp {
  final AuthRepository repository;

  SendOtp(this.repository);

  Future<Either<Failure, bool>> call(SendOtpParams params) async {
    return await repository.sendOtp(params.email);
  }
}

class SendOtpParams {
  final String email;
  
  SendOtpParams({required this.email});
}
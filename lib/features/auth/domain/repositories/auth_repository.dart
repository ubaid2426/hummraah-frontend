import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> verifyOtp(String email, String otp);
  Future<Either<Failure, bool>> sendOtp(String email); // Add this
  Future<Either<Failure, User>> signup(Map<String, dynamic> data); // Add this
}

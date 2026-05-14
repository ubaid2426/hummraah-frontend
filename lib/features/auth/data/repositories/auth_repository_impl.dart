// data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource remoteDataSource;
  late LocalStorageService _storageService;

  AuthRepositoryImpl({required this.remoteDataSource}) {
    _initStorage();
  }
  
  Future<void> _initStorage() async {
    _storageService = await LocalStorageService.getInstance();
  }

  @override
  Future<Either<Failure, User>> verifyOtp(String email, String otp) async {
    try {
      final user = await remoteDataSource.verifyOtp(email, otp);
      
      print('📦 Raw user data from API:');
      print('Access Token: ${user.accessToken != null ? "Present (${user.accessToken!.length} chars)" : "Missing"}');
      print('Refresh Token: ${user.refreshToken != null ? "Present" : "Missing"}');
      print('Email: ${user.email}');
      print('Full Name: ${user.fullName}');
      
      // Save tokens to local storage
      if (user.accessToken != null && user.accessToken!.isNotEmpty) {
        await _storageService.setString('token', user.accessToken!);
        print('✅ Token saved successfully');
        
        // Verify token was saved
        final savedToken = await _storageService.getString('token');
        print('🔍 Verification - Token saved: ${savedToken != null ? "Yes (${savedToken.length} chars)" : "No"}');
      } else {
        print('❌ ERROR: No access token received from backend!');
        return Left(ServerFailure("No access token received"));
      }
      
      if (user.refreshToken != null && user.refreshToken!.isNotEmpty) {
        await _storageService.setString('refreshToken', user.refreshToken!);
      }
      
      await _storageService.setString('userEmail', user.email);
      await _storageService.setString('userName', user.fullName);
      
      // Save user object
      await _storageService.setObject('user', {
        'email': user.email,
        'fullName': user.fullName,
        'accessToken': user.accessToken,
        'refreshToken': user.refreshToken,
      });
      
      print('✅ User data saved successfully');
      
      return Right(user);
    } catch (e) {
      print('❌ Verify OTP Error in Repository: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> sendOtp(String email) async {
    try {
      await remoteDataSource.sendOtp(email);
      return const Right(true);
    } catch (e) {
      print('❌ Send OTP Error in Repository: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signup(Map<String, dynamic> data) async {
    try {
      final user = await remoteDataSource.signup(data);
      return Right(user);
    } catch (e) {
      print('❌ Signup Error in Repository: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
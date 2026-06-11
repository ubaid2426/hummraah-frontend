// presentation/bloc/auth_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hummraah/core/services/local_storage_service.dart';
import 'package:hummraah/features/auth/domain/usecases/send_otp.dart';
import 'package:hummraah/features/auth/domain/usecases/singup.dart';
import 'package:hummraah/features/auth/domain/usecases/verify_otp.dart';

import '../../domain/entities/user.dart';

/// ===================== EVENTS =====================
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// SEND OTP EVENT
class SendOtpEvent extends AuthEvent {
  final String email;

  SendOtpEvent(this.email);

  @override
  List<Object?> get props => [email];
}

/// VERIFY OTP EVENT
class VerifyOtpEvent extends AuthEvent {
  final String email;
  final String otp;

  VerifyOtpEvent(this.email, this.otp);

  @override
  List<Object?> get props => [email, otp];
}

/// SIGNUP EVENT
class SignupEvent extends AuthEvent {
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

  SignupEvent({
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

  @override
  List<Object?> get props => [
    fullName,
    email,
    mobileNumber,
    password,
    address,
    emergencyNumber,
    country,
    cnic,
    passportNumber,
    passportExpiryDate,
  ];
}

/// ===================== STATES =====================
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

// In auth_bloc.dart, update the AuthSuccess class
class AuthSuccess extends AuthState {
  final User user; // Remove the '?' - make it non-nullable
  final String? message;

  AuthSuccess({required this.user, this.message}); // Make user required

  @override
  List<Object?> get props => [user, message];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// ===================== BLOC =====================
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtp sendOtp;
  final VerifyOtp verifyOtp;
  final Signup signup;
  final LocalStorageService _storageService = LocalStorageService();

  AuthBloc({
    required this.sendOtp,
    required this.verifyOtp,
    required this.signup,
  }) : super(AuthInitial()) {
    // on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<SignupEvent>(_onSignupEvent);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus); // Add this
    on<LogoutEvent>(_onLogout); // Add this
  }

  /// VERIFY OTP HANDLER
  Future<void> _onVerifyOtpEvent(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await verifyOtp(
      VerifyOtpParams(email: event.email, otp: event.otp),
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message ?? "Invalid OTP")),
      (user) {
        // Now user is guaranteed to be non-null
        emit(AuthSuccess(user: user, message: "Verification successful"));
      },
    );
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final token = await _storageService.getString('token');
    final userEmail = await _storageService.getString('userEmail');
    final userName = await _storageService.getString('userName');

    if (token != null &&
        token.isNotEmpty &&
        userEmail != null &&
        userName != null) {
      final user = User(
        email: userEmail,
        fullName: userName,
        accessToken: token,
      );
      emit(AuthSuccess(user: user));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _storageService.remove('token');
    await _storageService.remove('refreshToken');
    await _storageService.remove('userEmail');
    await _storageService.remove('userName');
    emit(AuthInitial());
  }

  Future<void> _saveUserData(User user) async {
    await _storageService.setString('token', user.accessToken ?? '');
    await _storageService.setString('refreshToken', user.refreshToken ?? '');
    await _storageService.setString('userEmail', user.email);
    await _storageService.setString('userName', user.fullName);
  }

  /// SIGNUP HANDLER
  Future<void> _onSignupEvent(
    SignupEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signup(
      SignupParams(
        fullName: event.fullName,
        email: event.email,
        mobileNumber: event.mobileNumber,
        password: event.password,
        address: event.address,
        emergencyNumber: event.emergencyNumber,
        country: event.country,
        cnic: event.cnic,
        passportNumber: event.passportNumber,
        passportExpiryDate: event.passportExpiryDate,
      ),
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message ?? "Signup failed")),
      (user) => emit(AuthSuccess(user: user, message: "Signup successful")),
    );
  }
}

class CheckAuthStatusEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

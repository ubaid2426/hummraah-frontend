// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain/usecases/login.dart';
// import '../../domain/entities/user.dart';

// abstract class AuthEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class LoginEvent extends AuthEvent {
//   final String email;
//   final String password;
//   LoginEvent(this.email, this.password);

//   @override
//   List<Object?> get props => [email, password];
// }

// abstract class AuthState extends Equatable {}

// class AuthInitial extends AuthState {
//   @override
//   List<Object?> get props => [];
// }

// class AuthLoading extends AuthState {
//   @override
//   List<Object?> get props => [];
// }

// class AuthSuccess extends AuthState {
//   final User user;
//   AuthSuccess(this.user);
//   @override
//   List<Object?> get props => [user];
// }

// class AuthFailure extends AuthState {
//   final String message;
//   AuthFailure(this.message);
//   @override
//   List<Object?> get props => [message];
// }

// // class AuthBloc extends Bloc<AuthEvent, AuthState> {
// //   final Login login;

// //   AuthBloc(this.login) : super(AuthInitial()) {
// //     on<LoginEvent>(_onLoginEvent);
// //   }

// //   void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
// //     emit(AuthLoading());
// //     final result = await login(event);
// //     result.fold(
// //       (failure) => emit(AuthFailure('Login failed')),
// //       (user) => emit(AuthSuccess(user)),
// //     );
// //   }
// // }
// // import '../../domain/usecases/login.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final Login login;

//   AuthBloc(this.login) : super(AuthInitial()) {
//     on<LoginEvent>(_onLoginEvent);
//   }

//   void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());

//     final result = await login(
//       LoginParams(
//         email: event.email,
//         password: event.password,
//       ),
//     );

//     result.fold(
//       (failure) => emit(AuthFailure('Login failed')),
//       (user) => emit(AuthSuccess(user)),
//     );
//   }
// }
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login.dart';
import '../../domain/entities/user.dart';

/// ===================== EVENTS =====================
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// LOGIN EVENT
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

/// SIGNUP EVENT (✔ ADDED)
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
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final User? user;
  final String? message;

  AuthSuccess({this.user, this.message});

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
  final Login login;

  AuthBloc(this.login) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<SignupEvent>(_onSignupEvent); // ✔ ADDED
  }

  /// LOGIN HANDLER
  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await login(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthFailure('Login failed')),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  /// SIGNUP HANDLER (✔ ADDED)
  Future<void> _onSignupEvent(
    SignupEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // IMPORTANT:
      // yahan tum repository inject karoge (agar chaaho main next step me add kar dunga)

      emit(AuthSuccess(message: "Signup successful"));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}

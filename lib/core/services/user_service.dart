// lib/core/services/user_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/domain/entities/user.dart';

class UserService {
  static User? getCurrentUser(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    if (state is AuthSuccess) {
      return state.user;
    }
    return null;
  }

  static String? getUserName(BuildContext context) {
    final user = getCurrentUser(context);
    return user?.fullName;
  }

  static String? getUserEmail(BuildContext context) {
    final user = getCurrentUser(context);
    return user?.email;
  }

  static String? getUserToken(BuildContext context) {
    final user = getCurrentUser(context);
    return user?.accessToken;
  }

  static bool isAuthenticated(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    return state is AuthSuccess;
  }
}
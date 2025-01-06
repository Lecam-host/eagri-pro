import 'package:equatable/equatable.dart';

import '../../../profile/model/user_model.dart';

class LoginState extends Equatable {
  final String? message;
  final bool isLoading;
  final int? statusCode;
  final bool isAuthenticated;

  const LoginState({
    this.message,
    this.isLoading = false,
    this.statusCode,
    this.isAuthenticated = true,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode, isAuthenticated];
}

class LoginSuccess extends LoginState {
  final UserModel user;

  const LoginSuccess({
    required this.user,
    super.message,
    super.isLoading,
    super.isAuthenticated = true,
  });

  @override
  List<Object?> get props => [user, message, isLoading, isAuthenticated];
}

class LoginFailed extends LoginState {
  const LoginFailed({
    required super.message,
    required super.isLoading,
    required super.statusCode,
    super.isAuthenticated = false,
  });

  @override
  List<Object?> get props => [message, isLoading, statusCode, isAuthenticated];
}

class UpdatePasswordSuccess extends LoginState {
  const UpdatePasswordSuccess(
      {super.message,
      super.isLoading,
      super.statusCode,
      super.isAuthenticated});

  @override
  List<Object?> get props => [message, isLoading, statusCode, isAuthenticated];
}

class UpdatePasswordFailed extends LoginState {
  const UpdatePasswordFailed(
      {super.message,
      super.isLoading,
      super.statusCode,
      super.isAuthenticated});

  @override
  List<Object?> get props => [message, isLoading, statusCode, isAuthenticated];
}

class ValidateSuccess extends LoginState {
  final UserModel user;
  const ValidateSuccess(
      {required this.user,
      super.message,
      super.isLoading,
      super.statusCode,
      super.isAuthenticated});

  @override
  List<Object?> get props =>
      [user, message, isLoading, statusCode, isAuthenticated];
}

class ValidateFailed extends LoginState {
  const ValidateFailed(
      {super.message,
      super.isLoading,
      super.statusCode,
      super.isAuthenticated});

  @override
  List<Object?> get props => [message, isLoading, statusCode, isAuthenticated];
}

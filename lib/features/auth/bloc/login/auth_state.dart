part of 'auth_bloc.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  splash,
  unknown,
}

class ResetPassordUserModel {
  final String? phoneNumber;
  final String? token;
  final String? password;

  ResetPassordUserModel(
      {required this.phoneNumber, required this.token, required this.password});
}

class AuthState extends Equatable {
  final AuthEntity? user;
  final AuthenticationStatus? status;
  final UserEntity? account;
  final UserModel? userModel;
  final Status stateStatus;
  final String? errorMessage;
  final bool showBottomNavBar;

  const AuthState(
      {this.user,
      this.status = AuthenticationStatus.splash,
      this.account,
      this.stateStatus = Status.initial,
      this.userModel,
      this.showBottomNavBar = true,
      this.errorMessage});
  AuthState copyWith(
      {AuthEntity? user,
      UserEntity? account,
      AuthenticationStatus? status,
      String? errorMessage,
      UserModel? userModel,
      Status? stateStatus,
      bool? showBottomNavBar}) {
    return AuthState(
        status: status ?? this.status,
        showBottomNavBar: showBottomNavBar ?? this.showBottomNavBar,
        user: user ?? this.user,
        stateStatus: stateStatus ?? this.stateStatus,
        errorMessage: errorMessage ?? this.errorMessage,
        userModel: userModel ?? this.userModel,
        account: account ?? this.account);
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status.toString(),
    };
  }

  factory AuthState.fromJson(Map<String, dynamic> json) {
    return AuthState(
      status: AuthenticationStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => AuthenticationStatus.unknown,
      ),
    );
  }

  @override
  List<Object?> get props => [
        user,
        account,
        status,
        stateStatus,
        errorMessage,
        userModel,
        showBottomNavBar
      ];
}

final class LoginInitial extends AuthState {
  const LoginInitial();
}

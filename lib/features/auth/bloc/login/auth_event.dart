part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SendRequestLogin extends AuthEvent {
  final String username;
  final String password;

  const SendRequestLogin({required this.username, required this.password});
}
class GetUserByIdEvent extends AuthEvent {
  final int id;

  const GetUserByIdEvent({required this.id});
}

class GetAccountEvent extends AuthEvent {
  const GetAccountEvent();
}

class ChangeAuthenticationStatusEvent extends AuthEvent{
  final AuthenticationStatus status;
  const ChangeAuthenticationStatusEvent({required this.status});
}

class ForgotPasswordEvent extends AuthEvent {
  final String phone;
  const ForgotPasswordEvent({required this.phone});
}

class CheckAuthentification extends AuthEvent {
  const CheckAuthentification();
}

class SendRequestLogout extends AuthEvent {
  final String userName;
  const SendRequestLogout({required this.userName});
}

class SendRequestRegistrationTokenEvent extends AuthEvent {
  final String? token;
  final String userName;
  const SendRequestRegistrationTokenEvent(
      { this.token, required this.userName});
}

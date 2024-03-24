part of 'sign_in_bloc.dart';

class SignInEvent {
  final String login;
  final String password;
  const SignInEvent({required this.login, required this.password});
}

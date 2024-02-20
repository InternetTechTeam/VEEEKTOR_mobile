part of 'auth_page_bloc.dart';

@immutable
sealed class AuthPageEvent {
  const AuthPageEvent();

  const factory AuthPageEvent.signIn({
    required String email,
    required String password,
  }) = _SignInEvent;
  factory AuthPageEvent.signUp({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String patronymic,
  }) = _SignUpEvent;
  factory AuthPageEvent.showSignInScreen() = _ShowSignInScreenEvent;
  factory AuthPageEvent.showSignUpScreen() = _ShowSignUpScreenEvent;
}

class _SignInEvent extends AuthPageEvent {
  final String email;
  final String password;

  const _SignInEvent({
    required this.email,
    required this.password,
  });
}

class _SignUpEvent extends AuthPageEvent {
  final String email;
  final String password;
  final String name;
  final String surname;
  final String patronymic;

  _SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.patronymic,
  });
}

class _ShowSignInScreenEvent extends AuthPageEvent {}

class _ShowSignUpScreenEvent extends AuthPageEvent {}

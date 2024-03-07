part of 'authefication_bloc.dart';

@immutable
sealed class AutheficationEvent {
  const AutheficationEvent();

  factory AutheficationEvent.intialize() => _InitializeEvent();

  const factory AutheficationEvent.signIn({
    required String login,
    required String password,
  }) = _SignInEvent;
  
  const factory AutheficationEvent.signUp({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String patronymic,
  }) = _SignUpEvent;
  
  factory AutheficationEvent.logOut() => _LogOutEvent();
}

class _InitializeEvent extends AutheficationEvent {}

class _SignInEvent extends AutheficationEvent {
  final String login;
  final String password;

  const _SignInEvent({
    required this.login,
    required this.password,
  });
}

class _SignUpEvent extends AutheficationEvent {
  final String email;
  final String password;
  final String name;
  final String surname;
  final String patronymic;

  const _SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.patronymic,
  });
}

class _LogOutEvent extends AutheficationEvent {}

part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();

  factory AuthEvent.init() => _InitAuthEvent();
  factory AuthEvent.logged() => _UserLoggedAuthEvent();
  factory AuthEvent.logout() => _UserLogoutAuthEvent();
}

class _InitAuthEvent extends AuthEvent {}

class _UserLoggedAuthEvent extends AuthEvent {}

class _UserLogoutAuthEvent extends AuthEvent {}
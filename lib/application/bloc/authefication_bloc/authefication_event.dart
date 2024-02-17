part of 'authefication_bloc.dart';

@immutable
sealed class AutheficationEvent {
  const AutheficationEvent();

  factory AutheficationEvent.intialize() => _InitializeEvent();
  factory AutheficationEvent.authorized() => _AuthorizedEvent();
  factory AutheficationEvent.logOut() => _LogOutEvent();
}

class _InitializeEvent extends AutheficationEvent {}

class _AuthorizedEvent extends AutheficationEvent {}

class _LogOutEvent extends AutheficationEvent {}
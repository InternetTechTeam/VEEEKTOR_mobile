part of 'authefication_bloc.dart';

@immutable
sealed class AutheficationState {
  const AutheficationState();

  factory AutheficationState.initial() = AutheficationInitialState;
  factory AutheficationState.autheficated() =
      AutheficatedState;
  factory AutheficationState.notAutheficated() = NotAutheficatedState;

  @override
  List<Object> get props => [];
}

final class AutheficationInitialState extends AutheficationState {}

final class AutheficatedState extends AutheficationState {}

final class NotAutheficatedState extends AutheficationState {}

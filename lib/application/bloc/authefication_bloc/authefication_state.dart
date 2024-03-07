part of 'authefication_bloc.dart';

class AutheficationState {
  AutheficationState({
    required this.status,
    this.errorMessage,
    this.login,
    this.password,
  });

  AutheficationStatus status;
  String? errorMessage;
  String? login;
  String? password;

  factory AutheficationState.initial() => AutheficationState(
        status: AutheficationStatus.nun,
        errorMessage: null,
        login: null,
        password: null,
      );

  AutheficationState copyWith({
    AutheficationStatus? status,
    String? errorMessage,
    String? login,
    String? password,
  }) =>
      AutheficationState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        login: login ?? this.login,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [status];
}

enum AutheficationStatus {
  autheficated,
  registrated,
  notAutheficated,
  loading,
  error,
  nun,
}

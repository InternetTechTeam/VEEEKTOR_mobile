part of 'auth_bloc.dart';

class AuthState {
  AuthStatus status;

  AuthState({required this.status});

  factory AuthState.initial() => AuthState(status: AuthStatus.nun);

  AuthState copyWith({
    AuthStatus? status,
  }) =>
      AuthState(
        status: status ?? this.status,
      );

  @override
  List<Object?> get props => [status];
}

enum AuthStatus {
  nun,
  autheficated,
  notAutheficated,
}

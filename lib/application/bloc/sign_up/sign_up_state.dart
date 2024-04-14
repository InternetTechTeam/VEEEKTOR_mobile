part of 'sign_up_bloc.dart';

class SignUpState {
  SignUpStatus status;
  String? login;
  String? password;
  String? errorMessage;

  SignUpState({
    required this.status,
    this.errorMessage,
    this.login,
    this.password,
  });

  factory SignUpState.initial() => SignUpState(
        status: SignUpStatus.nun,
        errorMessage: null,
        login: null,
        password: null,
      );

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorMessage,
    String? login,
    String? password,
  }) =>
      SignUpState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        login: login ?? this.login,
        password: password ?? this.password,
      );

  List<Object?> get props => [status];
}

enum SignUpStatus { nun, loading, success, failure }

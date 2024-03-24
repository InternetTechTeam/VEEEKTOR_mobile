part of 'sign_in_bloc.dart';

class SignInState {
  SignInStatus status;
  String? errorMessage;

  SignInState({required this.status, this.errorMessage});

  factory SignInState.initial() => SignInState(
        status: SignInStatus.nun,
        errorMessage: null,
      );

  SignInState copyWith({
    SignInStatus? status,
    String? errorMessage,
  }) =>
      SignInState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  List<Object?> get props => [status];
}

enum SignInStatus { nun, loading, failure, success }

part of 'sign_up_bloc.dart';

class SignUpState {
  SignUpStatus status;
  String? errorMessage;

  SignUpState({required this.status, this.errorMessage});

  factory SignUpState.initial() => SignUpState(
        status: SignUpStatus.nun,
        errorMessage: null,
      );

  SignUpState copyWith({
    SignUpStatus? status,
    String? errorMessage,
  }) =>
      SignUpState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  List<Object?> get props => [status];
}

enum SignUpStatus { nun, loading, success, failure }

part of 'sign_in_page_bloc.dart';

class SignInPageState {
  Status status;
  String? errorMessage;

  SignInPageState({required this.status, this.errorMessage});

  factory SignInPageState.initial() =>
      SignInPageState(status: Status.nun, errorMessage: null);

  SignInPageState copyWith({
    Status? status,
    String? errorMessage,
  }) =>
      SignInPageState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [status];
}

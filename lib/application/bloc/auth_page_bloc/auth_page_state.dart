part of 'auth_page_bloc.dart';

class AuthPageState {
  Status status;
  String? errorMessage;

  AuthPageState({required this.status, this.errorMessage});

  factory AuthPageState.initial() =>
      AuthPageState(status: Status.nun, errorMessage: null);

  AuthPageState copyWith({
    Status? status,
    String? errorMessage,
  }) =>
      AuthPageState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [status];
}

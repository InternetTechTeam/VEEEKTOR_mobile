part of 'auth_page_bloc.dart';

@immutable
sealed class AuthPageState {
  const AuthPageState();

  factory AuthPageState.intiial() = AuthPageInitial;
  factory AuthPageState.loading() = AuthPageLoadingState;
  factory AuthPageState.signIn() = AuthPageSignInState;
  factory AuthPageState.signUp() = AuthPageSignUpState;
  factory AuthPageState.failure() = AuthPageFailureState;


  @override
  List<Object> get props => [];
}

final class AuthPageInitial extends AuthPageState {}

final class AuthPageLoadingState extends AuthPageState {}

final class AuthPageSignInState extends AuthPageState {}

final class AuthPageSignUpState extends AuthPageState {}

final class AuthPageFailureState extends AuthPageState {}

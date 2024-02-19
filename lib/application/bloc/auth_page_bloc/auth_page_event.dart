part of 'auth_page_bloc.dart';

@immutable
sealed class AuthPageEvent {
  const AuthPageEvent();

  factory AuthPageEvent.signIn() = _SignInEvent;
  factory AuthPageEvent.signUp() = _SignUpEvent;
  factory AuthPageEvent.showSignInScreen() = _ShowSignInScreenEvent;
  factory AuthPageEvent.showSignUpScreen() = _ShowSignUpScreenEvent;
}

class _SignInEvent extends AuthPageEvent {}

class _SignUpEvent extends AuthPageEvent {}

class _ShowSignInScreenEvent extends AuthPageEvent {}

class _ShowSignUpScreenEvent extends AuthPageEvent {}

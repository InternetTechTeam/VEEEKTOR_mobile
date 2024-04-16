part of 'auth_page_bloc.dart';

class AuthPageEvent {
  AuthPageEvent();

  factory AuthPageEvent.signIn({required SignInFormModel form}) => _SignInEvent(form: form);
}

class _SignInEvent extends AuthPageEvent {
  SignInFormModel form;

  _SignInEvent({required this.form});
}

class _SignUpEvent extends AuthPageEvent {
  SignUpFormModel form;

  _SignUpEvent({required this.form});
}
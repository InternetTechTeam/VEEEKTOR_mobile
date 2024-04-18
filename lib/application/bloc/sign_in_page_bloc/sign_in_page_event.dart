part of 'sign_in_page_bloc.dart';

class SignInPageEvent {
  SignInPageEvent();

  factory SignInPageEvent.signIn({required SignInFormModel form}) =>
      _SignInEvent(form: form);
  factory SignInPageEvent.signUp({required SignUpFormModel form}) =>
      _SignUpEvent(form: form);
}

class _SignInEvent extends SignInPageEvent {
  SignInFormModel form;

  _SignInEvent({required this.form});
}

class _SignUpEvent extends SignInPageEvent {
  SignUpFormModel form;

  _SignUpEvent({required this.form});
}

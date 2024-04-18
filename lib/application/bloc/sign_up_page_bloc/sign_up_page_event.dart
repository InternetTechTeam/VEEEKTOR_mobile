part of 'sign_up_page_bloc.dart';

@immutable
sealed class SignUpPageEvent {
  const SignUpPageEvent();
  factory SignUpPageEvent.loadingDeps({required int envId}) =>
      _LoadingDepsEvent(envId: envId);
  factory SignUpPageEvent.loadingEnvs() => _LoadingEnvsEvent();
  factory SignUpPageEvent.signUp({required SignUpFormModel form}) =>
      _SignUpEvent(form: form);
  factory SignUpPageEvent.changeDepDropdownActivity({required bool value}) =>
      _ChangedDepDropdownActivity(value: value);
}

class _LoadingEnvsEvent extends SignUpPageEvent {}

class _LoadingDepsEvent extends SignUpPageEvent {
  final int envId;

  _LoadingDepsEvent({required this.envId});
}

class _SignUpEvent extends SignUpPageEvent {
  final SignUpFormModel form;

  _SignUpEvent({required this.form});
}

class _ChangedDepDropdownActivity extends SignUpPageEvent {
  final bool value;

  _ChangedDepDropdownActivity({required this.value});
}

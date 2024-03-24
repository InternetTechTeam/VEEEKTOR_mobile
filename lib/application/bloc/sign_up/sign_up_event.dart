part of 'sign_up_bloc.dart';

class SignUpEvent {
  final String email;
  final String password;
  final String name;
  final String surname;
  final String patronymic;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.surname,
    required this.patronymic,
  });
}

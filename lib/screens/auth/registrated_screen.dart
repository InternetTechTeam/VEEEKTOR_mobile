import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth/auth_bloc.dart';
import 'package:veeektor/application/bloc/sign_in/sign_in_bloc.dart';

class RegistratedScreen extends StatelessWidget {
  final String login;
  final String password;
  const RegistratedScreen({
    super.key,
    required this.login,
    required this.password,
  });

  static Route<dynamic> route(
          {required String login, required String password}) =>
      MaterialPageRoute(
          builder: (context) => RegistratedScreen(
                login: login,
                password: password,
              ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Succefuly registrated!"),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<SignInBloc>(context)
                  .add(SignInEvent(login: login, password: password));
            },
            child: const Text("Sign In"),
          ),
        ],
      ),
    );
  }
}

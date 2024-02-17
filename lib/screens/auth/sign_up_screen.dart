import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth_page_bloc/auth_page_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _onPressed() {
      BlocProvider.of<AuthPageBloc>(context)
          .add(AuthPageEvent.showSignInScreen());
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Sign Up screen"),
          ElevatedButton(
            onPressed: _onPressed,
            child: const Text("Sign In"),
          ),
        ],
      ),
    );
  }
}

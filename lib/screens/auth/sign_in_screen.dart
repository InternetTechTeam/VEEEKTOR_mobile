import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth_page_bloc/auth_page_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _onPressed() {
      BlocProvider.of<AuthPageBloc>(context)
          .add(AuthPageEvent.showSignUpScreen());
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Sign In screen"),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthPageBloc>(context)
                  .add(AuthPageEvent.signIn());
            },
            child: Text("SignIn"),
          ),
          ElevatedButton(
            onPressed: _onPressed,
            child: const Text("Sign Up"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth_page_bloc/auth_page_bloc.dart';
import 'package:veeektor/widgets/text_input_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SignInForm(),
          TextButton(
            onPressed: () {},
            child: Text("Forgot password"),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthPageBloc>(context)
                    .add(AuthPageEvent.signIn());
              },
              child: Text("Sign In"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("New to VEEEKTOR?"),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthPageBloc>(context)
                      .add(AuthPageEvent.showSignUpScreen());
                },
                child: Text("Create account"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Text("Sign in"),
          TextInputWidget(
            controller: _emailController,
            label: "email",
            obscureText: false,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          TextInputWidget(
            controller: _passwordController,
            label: "Password",
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth_page_bloc/auth_page_bloc.dart';
import 'package:veeektor/widgets/text_input_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _onPressed() {
      BlocProvider.of<AuthPageBloc>(context)
          .add(AuthPageEvent.showSignInScreen());
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignUpForm(),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthPageBloc>(context)
                  .add(AuthPageEvent.signUp());
            },
            child: const Text("Sign up"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have account?"),
              TextButton(
                onPressed: () {
                  BlocProvider.of<AuthPageBloc>(context)
                      .add(AuthPageEvent.showSignInScreen());
                },
                child: Text("Sign In"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _fathernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _fathernameController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Text("Sign Up"),
          TextInputWidget(
            controller: _nameController,
            label: "name",
            obscureText: false,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          TextInputWidget(
            controller: _surnameController,
            label: "surname",
            obscureText: false,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          TextInputWidget(
            controller: _fathernameController,
            label: "fathername",
            obscureText: false,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          TextInputWidget(
            controller: _emailController,
            label: "email",
            obscureText: false,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          TextInputWidget(
            controller: _passwordController,
            label: "password",
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

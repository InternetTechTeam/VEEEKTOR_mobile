import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth_page_bloc/auth_page_bloc.dart';
import 'package:veeektor/widgets/text_input_widget.dart';

class SignUpScreen extends StatelessWidget {
  late final TextEditingController _nameController;
  late final TextEditingController _surnameController;
  late final TextEditingController _fathernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final SignUpForm _form;
  SignUpScreen({super.key}) {
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _fathernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _form = SignUpForm(
      nameController: _nameController,
      surnameController: _surnameController,
      fathernameController: _fathernameController,
      emailController: _emailController,
      passwordController: _passwordController,
    );
  }

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
          _form,
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthPageBloc>(context).add(AuthPageEvent.signUp(
                email: _emailController.text,
                password: _passwordController.text,
                name: _nameController.text,
                surname: _surnameController.text,
                patronymic: _fathernameController.text,
              ));
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
                  _emailController.clear();
                  _fathernameController.clear();
                  _nameController.clear();
                  _passwordController.clear();
                  _surnameController.clear();
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
  const SignUpForm({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.fathernameController,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController fathernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Text("Sign Up"),
          TextInputWidget(
            controller: widget.nameController,
            label: "name",
            obscureText: false,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          TextInputWidget(
            controller: widget.surnameController,
            label: "surname",
            obscureText: false,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          TextInputWidget(
            controller: widget.fathernameController,
            label: "fathername",
            obscureText: false,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          TextInputWidget(
            controller: widget.emailController,
            label: "email",
            obscureText: false,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          TextInputWidget(
            controller: widget.passwordController,
            label: "password",
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

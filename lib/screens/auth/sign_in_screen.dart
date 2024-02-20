import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth_page_bloc/auth_page_bloc.dart';
import 'package:veeektor/widgets/text_input_widget.dart';

class SignInScreen extends StatelessWidget {
  late final TextEditingController _emailController;
  late final _passwordController;
  late final _globalKey;
  late final SignInForm _form;
  SignInScreen({super.key}) {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _globalKey = GlobalKey<FormState>();
    _form = SignInForm(
      emailController: _emailController,
      passwordController: _passwordController,
      globalKey: _globalKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _form,
          TextButton(
            onPressed: () {},
            child: Text("Forgot password"),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthPageBloc>(context).add(AuthPageEvent.signIn(
                  email: _emailController.text,
                  password: _passwordController.text,
                ));
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
                  _emailController.clear();
                  _passwordController.clear();
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
  late final TextEditingController emailController;
  final passwordController;
  final globalKey;

  SignInForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.globalKey,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.globalKey,
      child: Column(
        children: [
          Text("Sign in"),
          TextInputWidget(
            controller: widget.emailController,
            label: "email",
            obscureText: false,
          ),
          Padding(padding: EdgeInsets.only(top: 5)),
          TextInputWidget(
            controller: widget.passwordController,
            label: "Password",
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

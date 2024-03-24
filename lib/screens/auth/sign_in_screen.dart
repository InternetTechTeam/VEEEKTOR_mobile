import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/sign_in/sign_in_bloc.dart';
import 'package:veeektor/application/models/progress_dialog.dart';
import 'package:veeektor/screens/auth/sign_up_screen.dart';
import 'package:veeektor/widgets/text_input_widget.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status != SignInStatus.loading) {
            LoadingIndicatorDialog.dismiss();
          }
          switch (state.status) {
            case SignInStatus.loading:
              LoadingIndicatorDialog.show(context);
              break;
            case SignInStatus.failure:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(state.errorMessage ?? "something going wrong..."),
                ),
              );
              break;
            default:
              break;
          }
        },
        child: Padding(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("New to VEEEKTOR?"),
                  TextButton(
                    onPressed: () {
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     SignUpScreen.route(), (route) => false);
                    },
                    child: Text("Create account"),
                  ),
                ],
              ),
            ],
          ),
        ),
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
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
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
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<SignInBloc>(context).add(
                SignInEvent(
                  login: _emailController.text,
                  password: _passwordController.text,
                ),
              );
            },
            child: Text("Sign In"),
          ),
        ],
      ),
    );
  }
}

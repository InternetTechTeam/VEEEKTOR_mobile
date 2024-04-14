import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/sign_up/sign_up_bloc.dart';
import 'package:veeektor/screens/auth/registrated_screen.dart';
import 'package:veeektor/screens/auth/sign_up_env_page.dart';
import 'package:veeektor/screens/auth/sign_up_lp_page.dart';
import 'package:veeektor/screens/auth/sign_up_nsp_page.dart';
import 'package:veeektor/widgets/progress_dialog.dart';
import 'package:veeektor/screens/auth/sign_in_screen.dart';
import 'package:veeektor/widgets/text_input_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => const SignUpScreen());

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _fathernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _fathernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        controller: _pageController,
        children: [
          SignUpNSPPage(
            nameController: _nameController,
            surnameController: _surnameController,
            patronymicController: _fathernameController,
          ),
          SignUpLPPage(),
          SignUpEnvPage(),
        ],
      ),
    );
  }
}

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({super.key});

//   static Route<dynamic> route() =>
//       MaterialPageRoute(builder: (context) => const SignUpScreen());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocListener<SignUpBloc, SignUpState>(
//         listenWhen: (previous, current) => previous.status != current.status,
//         listener: (context, state) {
//           switch (state.status) {
//             case SignUpStatus.loading:
//               LoadingIndicatorDialog.show(context);
//               break;
//             case SignUpStatus.failure:
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content:
//                       Text(state.errorMessage ?? "something going wrong..."),
//                 ),
//               );
//               break;
//             case SignUpStatus.success:
//               Navigator.of(context).pushAndRemoveUntil(
//                   RegistratedScreen.route(
//                     login: state.login!,
//                     password: state.password!,
//                   ),
//                   (route) => false);
//               break;
//             default:
//               break;
//           }
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SignUpForm(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Already have account?"),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pushAndRemoveUntil(
//                           SignInScreen.route(), (route) => false);
//                     },
//                     child: const  Text("Sign In"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SignUpForm extends StatefulWidget {
//   const SignUpForm({super.key});

//   @override
//   State<SignUpForm> createState() => _SignUpFormState();
// }

// class _SignUpFormState extends State<SignUpForm> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _surnameController = TextEditingController();
//   final TextEditingController _fathernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _surnameController.dispose();
//     _fathernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: [
//           const Text("Sign Up"),
//           TextInputWidget(
//             controller: _nameController,
//             label: "name",
//             obscureText: false,
//           ),
//           const Padding(padding: EdgeInsets.only(top: 5)),
//           TextInputWidget(
//             controller: _surnameController,
//             label: "surname",
//             obscureText: false,
//           ),
//           const Padding(padding: EdgeInsets.only(top: 5)),
//           TextInputWidget(
//             controller: _fathernameController,
//             label: "fathername",
//             obscureText: false,
//           ),
//           const Padding(padding: EdgeInsets.only(top: 5)),
//           TextInputWidget(
//             controller: _emailController,
//             label: "email",
//             obscureText: false,
//           ),
//           const Padding(padding: EdgeInsets.only(top: 5)),
//           TextInputWidget(
//             controller: _passwordController,
//             label: "password",
//             obscureText: true,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               BlocProvider.of<SignUpBloc>(context).add(SignUpEvent(
//                 email: _emailController.text,
//                 password: _passwordController.text,
//                 name: _nameController.text,
//                 surname: _surnameController.text,
//                 patronymic: _fathernameController.text,
//               ));
//             },
//             child: const Text("Sign up"),
//           ),
//         ],
//       ),
//     );
//   }
// }

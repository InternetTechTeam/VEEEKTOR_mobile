// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RegistratedScreen extends StatelessWidget {
//   const RegistratedScreen({super.key});

//   static Route<dynamic> route() =>
//       MaterialPageRoute(builder: (context) => const RegistratedScreen());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text("Succefuly registrated!"),
//           ElevatedButton(
//             onPressed: () {
//               final login =
//                   BlocProvider.of<AutheficationBloc>(context).state.login;
//               final password =
//                   BlocProvider.of<AutheficationBloc>(context).state.password;
//               BlocProvider.of<AutheficationBloc>(context)
//                   .add(AutheficationEvent.signIn(
//                 login: login!,
//                 password: password!,
//               ));
//             },
//             child: const Text("Sign In"),
//           ),
//         ],
//       ),
//     );
//   }
// }

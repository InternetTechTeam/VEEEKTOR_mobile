import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/authefication_bloc/authefication_bloc.dart';
import 'package:veeektor/application/models/progress_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            LoadingIndicatorDialog.show(context);
            BlocProvider.of<AutheficationBloc>(context).add(AutheficationEvent.logOut());
          },
          child: Text("Log out"),
        ),
      ),
    );
  }
}
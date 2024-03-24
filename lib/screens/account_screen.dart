import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth/auth_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => BlocProvider.of<AuthBloc>(context).add(AuthEvent.logout()),
          child: Text("log out"),
        ),
      ),
    );
  }
}
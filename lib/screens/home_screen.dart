import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth/auth_bloc.dart';
import 'package:veeektor/application/models/progress_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder(),
    );
  }
}

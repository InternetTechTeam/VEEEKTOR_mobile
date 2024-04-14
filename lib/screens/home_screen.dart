import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veeektor/application/bloc/auth/auth_bloc.dart';
import 'package:veeektor/widgets/progress_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Курсы"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
      body: Placeholder(),
    );
  }
}

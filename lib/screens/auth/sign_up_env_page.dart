import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpEnvPage extends StatefulWidget {
  const SignUpEnvPage({super.key});

  @override
  State<SignUpEnvPage> createState() => _SignUpEnrPageState();
}

class _SignUpEnrPageState extends State<SignUpEnvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Страница с выбором организации"),
      ),
    );
  }
}
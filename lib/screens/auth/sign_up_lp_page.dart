import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpLPPage extends StatefulWidget {
  const SignUpLPPage({super.key});

  @override
  State<SignUpLPPage> createState() => _SignUpLPPageState();
}

class _SignUpLPPageState extends State<SignUpLPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Странца с логином и паролем"),
      ),
    );
  }
}
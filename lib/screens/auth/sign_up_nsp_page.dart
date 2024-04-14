import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SignUpNSPPage extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController patronymicController;
  const SignUpNSPPage({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.patronymicController,
  });

  @override
  State<SignUpNSPPage> createState() => _SignUpNSPPageState();
}

class _SignUpNSPPageState extends State<SignUpNSPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Страница с ФИО"),
      ),
    );
  }
}

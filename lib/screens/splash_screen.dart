import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static Route<dynamic> route() => MaterialPageRoute(builder: (context) => const SplashScreen());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox.square(
          dimension: 40,
          child: Placeholder(),
        ),
      ),
    );
  }
}
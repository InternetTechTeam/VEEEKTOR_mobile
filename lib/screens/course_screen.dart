import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => CourseScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Страница курса"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Страница курса!"),
      ),
    );
  }
}

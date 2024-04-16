import 'package:flutter/material.dart';
import 'package:veeektor/screens/account_screen.dart';
import 'package:veeektor/screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => const BottomBar(),
      );

  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currIdx = 0;
  static final _pages = [
    HomeScreen(),
    AccoutScreen(),
  ];

  void _onTap(idx) {
    setState(() {
      _currIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_currIdx),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "account",
          ),
        ],
        currentIndex: _currIdx,
        onTap: _onTap,
      ),
    );
  }
}

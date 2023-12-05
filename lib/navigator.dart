import 'package:flutter/material.dart';
import 'custom_icons_icons.dart';
import 'homepage.dart';
import 'earnings.dart';
import 'reports.dart';
import 'goals.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(),
    );
  }
}

class Navigator extends StatefulWidget {
  @override
  _NavigatorState createState() => _NavigatorState();
}

class _NavigatorState extends State<Navigator> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    HomePage(),
    Goals(),
    Reports(),
    Profit(),

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: CustomNavigationBar(
          currentIndex: _selectedIndex,
          iconSize: 30.0,
          selectedColor: Colors.white,
          strokeColor: Colors.white,
          unSelectedColor: Colors.white,
          backgroundColor: const Color(0xff363490),
          items: [
            CustomNavigationBarItem(
              icon: const Icon(Icons.home, color: Colors.white),
              title: const Text(
                'Início',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CustomNavigationBarItem(
              icon: const Icon(CustomIcons.goals, color: Colors.white),
              title: const Text(
                'Metas',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.calendar_month_outlined, color: Colors.white),
              title: const Text(
                'Relatórios',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            CustomNavigationBarItem(
              icon: const Icon(Icons.wallet_outlined, color: Colors.white),
              title: const Text(
                'Lucro',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
          onTap: (i) {
            setState(() {
              _selectedIndex = i;
            });
          },
        ),
      ),
    );
  }
}

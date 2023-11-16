import 'package:flutter/material.dart';
import 'package:trackify/screens/home_screen.dart';
import 'package:trackify/screens/transaction_screen.dart';
import 'package:trackify/widgets/navbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  List<dynamic> pageViewList = [
    HomeScreen(),
    TransactionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (int value) {
            setState(() {
              currentIndex = value;
            });
          }),
      body: pageViewList[currentIndex],
    );
  }
}

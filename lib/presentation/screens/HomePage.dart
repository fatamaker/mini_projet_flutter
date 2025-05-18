import 'package:flutter/material.dart';
import 'package:flutter_application_ngrk/presentation/screens/OrdersListScreen.dart';
import 'package:flutter_application_ngrk/presentation/screens/UserScreen.dart';
import 'package:flutter_application_ngrk/presentation/screens/home_screen.dart';
import 'package:flutter_application_ngrk/presentation/widgets/BottomNavBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    UserScreen(),
    OrdersListScreen(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTabChange: _onTabChange, // Adjusted to match the updated BottomNavBar
      ),
    );
  }
}

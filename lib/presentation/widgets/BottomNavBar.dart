import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange; // Callback to handle tab change
  final int currentIndex; // Current index of selected tab

  // Constructor to receive currentIndex and onTabChange callback
  const BottomNavBar(
      {super.key, required this.onTabChange, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'produit',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'personne',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.create_new_folder_rounded),
          label: 'commende',
        ),
      ],
      currentIndex: currentIndex, // Updates the selected index
      selectedItemColor:
          Color.fromARGB(255, 223, 174, 12), // Color when item is selected
      unselectedItemColor: Colors.grey, // Color when item is not selected
      onTap:
          onTabChange, // Executes the onTabChange callback when a tab is clicked
    );
  }
}

import 'package:flutter/material.dart';
import 'package:neuroassist/calmdown.dart';
import 'package:neuroassist/moodtoaction.dart';
import 'package:neuroassist/safeexit.dart';

// Import your existing app pages

class BottomNavBarApp extends StatefulWidget {
  const BottomNavBarApp({super.key});

  @override
  _BottomNavBarAppState createState() => _BottomNavBarAppState();
}

class _BottomNavBarAppState extends State<BottomNavBarApp> {
  int _selectedIndex = 0;

  // List of widgets to display for each bottom navigation item
  static final List<Widget> _widgetOptions = <Widget>[
    MoodToActionApp(),
    FakeCallTriggerScreen(),
    NeuroAssistApp(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(
          _selectedIndex,
        ), // Display the selected page
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.mood), label: 'Mood Action'),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Fake Call'),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Neuro Assist',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Customize the selected item color
        unselectedItemColor: Colors.grey, // Customize the unselected item color
        onTap: _onItemTapped,
      ),
    );
  }
}

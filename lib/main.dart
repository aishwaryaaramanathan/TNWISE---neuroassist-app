import 'package:flutter/material.dart';
import 'package:neuroassist/calmdown.dart';
import 'package:neuroassist/focussession.dart';
import 'package:neuroassist/moodtoaction.dart';
import 'package:neuroassist/safeexit.dart';
// Import your other screens
// Assuming MoodToActionApp is in main.dart
//Import settings page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Health App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: BottomNavScreen(), // Set BottomNavScreen as the home page
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  // List of widgets to display for each bottom navigation item
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // Keep HomeScreen in the list
    SettingsScreen(),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mental Health Companion'),
        leading: null, // REMOVED back button here
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0), // Reduced padding
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12, // Reduced spacing
          mainAxisSpacing: 12, // Reduced spacing
          childAspectRatio: 0.9, // Make cubicles slightly taller than square
          children: <Widget>[
            _buildFeatureCubicle(context, 'Mood to Action', MoodToActionApp()),
            _buildFeatureCubicle(context, 'Safe Exit', FakeCallTriggerScreen()),
            _buildFeatureCubicle(
              context,
              'Calm Down',
              NeuroAssistApp(),
            ), // Replace with your CalmDownScreen
            _buildFeatureCubicle(
              context,
              'Focus Sessions',
              FocusSessionScreen(),
            ), // Replace with your FocusSessionsScreen
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCubicle(
    BuildContext context,
    String title,
    Widget destination,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(10), // Slightly less rounded
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1, // Reduced spread
              blurRadius: 3, // Reduced blur
              offset: Offset(0, 2), // Slightly smaller offset
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16, // Reduced font size
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        leading: IconButton(
          // Back button added
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Settings Page Content', // Replace with your settings UI
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

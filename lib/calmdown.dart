import 'package:flutter/material.dart';

class NeuroAssistApp extends StatelessWidget {
  const NeuroAssistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuroAssist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const CalmDownScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalmDownScreen extends StatefulWidget {
  const CalmDownScreen({super.key});

  @override
  State<CalmDownScreen> createState() => _CalmDownScreenState();
}

class _CalmDownScreenState extends State<CalmDownScreen>
    with TickerProviderStateMixin {
  // Calming pastel colors as specified
  final List<Color> _calmingColors = [
    const Color(0xFFADD8E6), // Light blue
    const Color(0xFFB0E0B0), // Light green
    const Color(0xFFD8BFD8), // Light purple
    const Color(0xFFB0E0E0), // Light teal
  ];

  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  int _currentColorIndex = 0;
  int _nextColorIndex = 1;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  void _setupAnimation() {
    // Setup controller with 3-second duration (1s transition + 2s display)
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Set up the color animation
    _updateColorAnimation();

    // Handle animation completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          // Update color indices
          _currentColorIndex = _nextColorIndex;
          _nextColorIndex = (_nextColorIndex + 1) % _calmingColors.length;

          // Reset and update animation
          _controller.reset();
          _updateColorAnimation();
          _controller.forward();
        });
      }
    });

    // Start the animation
    _controller.forward();
  }

  void _updateColorAnimation() {
    _colorAnimation = ColorTween(
      begin: _calmingColors[_currentColorIndex],
      end: _calmingColors[_nextColorIndex],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        // Use the first 1/3 of the animation for the color transition
        curve: const Interval(0.0, 0.33, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: _colorAnimation.value,
            child: const Center(
              child: Text(
                "Calm Down",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

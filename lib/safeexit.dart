import 'package:flutter/material.dart';
import 'dart:async'; // Import the async library for Timer

class FakeCallTriggerScreen extends StatefulWidget {
  const FakeCallTriggerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FakeCallTriggerScreenState createState() => _FakeCallTriggerScreenState();
}

class _FakeCallTriggerScreenState extends State<FakeCallTriggerScreen> {
  bool _isCallScreenVisible = false;
  bool _isCallActive = false;
  final String _callerName = "Unknown";
  final String _callerImage = "assets/default_contact.png";
  Duration _callDuration = Duration.zero;
  Timer? _timer;

  void _showFakeCallScreen() {
    setState(() {
      _isCallScreenVisible = true;
    });
  }

  void _answerFakeCall() {
    setState(() {
      _isCallActive = true;
      _callDuration = Duration.zero;
    });
    _startTimer();
  }

  void _endFakeCall() {
    setState(() {
      _isCallScreenVisible = false;
      _isCallActive = false;
      _callDuration = Duration.zero;
    });
    _stopTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _callDuration = _callDuration + Duration(seconds: 1);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String minutes = twoDigits(duration.inMinutes.remainder(60));
    final String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          _isCallActive
              ? null // Remove AppBar when call is active
              : AppBar(title: Text('Discreet Exit')),
      body: Stack(
        children: <Widget>[
          Center(
            child: Visibility(
              visible: !_isCallScreenVisible,
              child: ElevatedButton(
                onPressed: _showFakeCallScreen,
                child: Text('Trigger Fake Call'),
              ),
            ),
          ),
          if (_isCallScreenVisible) _buildFakeCallScreen(context),
        ],
      ),
    );
  }

  Widget _buildFakeCallScreen(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 20,
                  ), // Adjust for status bar
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(_callerImage),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(height: 20),
                  Text(
                    _callerName,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _isCallActive
                        ? _formatDuration(_callDuration)
                        : 'Incoming Call...',
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.mic_off,
                        color: Colors.grey[700],
                        size: 36,
                      ),
                      onPressed: () {
                        // Implement mute functionality
                      },
                    ),
                    if (!_isCallActive)
                      IconButton(
                        icon: Icon(Icons.call_end, color: Colors.red, size: 48),
                        onPressed: _endFakeCall, // "Decline" button
                      )
                    else
                      IconButton(
                        icon: Icon(Icons.call_end, color: Colors.red, size: 48),
                        onPressed: _endFakeCall, // "Hang up" button
                      ),
                    IconButton(
                      icon: Icon(
                        Icons.speaker_phone,
                        color: Colors.grey[700],
                        size: 36,
                      ),
                      onPressed: () {
                        // Implement speakerphone functionality
                      },
                    ),
                    if (!_isCallActive)
                      IconButton(
                        icon: Icon(Icons.call, color: Colors.green, size: 48),
                        onPressed: _answerFakeCall, // "Answer" button
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

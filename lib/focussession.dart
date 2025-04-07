import 'package:flutter/material.dart';
import 'dart:async';

class FocusSessionScreen extends StatefulWidget {
  const FocusSessionScreen({super.key});

  @override
  _FocusSessionScreenState createState() => _FocusSessionScreenState();
}

class _FocusSessionScreenState extends State<FocusSessionScreen> {
  int _focusTime = 25; // Default focus time in minutes
  bool _isTimerRunning = false;
  Timer? _timer;
  int _secondsRemaining = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    if (_isTimerRunning) return;

    setState(() {
      _isTimerRunning = true;
      _secondsRemaining = _focusTime * 60;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _stopTimer();
        // Show a dialog with a calming background and supportive message
        showDialog(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.blue[100], // Calming light blue background
              child: AlertDialog(
                backgroundColor:
                    Colors.transparent, // Make the dialog itself transparent
                title: Text(
                  'Focus Session Ended',
                  style: TextStyle(
                    color: Colors.blue[800], // Darker blue for the title
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  'Great job! You completed your focus session.  Remember to take a short break and relax.',
                  style: TextStyle(
                    color: Colors.grey[800], // Darker grey for the message
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.blue,
                      ), // Blue for the button text
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
    _timer?.cancel();
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Focus Session'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Set your focus time:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_focusTime > 1) _focusTime--;
                    });
                  },
                ),
                SizedBox(width: 20),
                Text(
                  '$_focusTime min',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _focusTime++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Text('Time Remaining:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(
              _isTimerRunning
                  ? _formatDuration(_secondsRemaining)
                  : _formatDuration(_focusTime * 60),
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isTimerRunning ? _stopTimer : _startTimer,
              child: Text(
                _isTimerRunning ? 'Stop Focus Session' : 'Start Focus Session',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

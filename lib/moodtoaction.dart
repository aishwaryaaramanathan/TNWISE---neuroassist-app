import 'package:flutter/material.dart';

void main() {
  runApp(MoodToActionApp());
}

class MoodToActionApp extends StatelessWidget {
  const MoodToActionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood to Action',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MoodSelectorScreen(),
    );
  }
}

class MoodSelectorScreen extends StatefulWidget {
  const MoodSelectorScreen({super.key});

  @override
  _MoodSelectorScreenState createState() => _MoodSelectorScreenState();
}

class _MoodSelectorScreenState extends State<MoodSelectorScreen> {
  String? _selectedMood;
  List<String> _suggestions = [];

  // Define your mood to action mapping here
  final Map<String, List<String>> _moodToActionMap = {
    '😊': [
      "Take a moment to appreciate something good.",
      "Listen to an uplifting song.",
    ],
    '😔': [
      "Try a gentle stretching exercise.",
      "Reach out to a friend or family member.",
    ],
    '😠': [
      "Take 5 deep breaths.",
      "Step away from the situation for a few minutes.",
    ],
    '😟': [
      "Write down your thoughts and feelings.",
      "Engage in a calming hobby like reading.",
    ],
    '😨': [
      "Focus on your senses: what do you see, hear, smell?",
      "Try a grounding technique.",
    ],
    '🤯': [
      "Hide notifications for 15 minutes.",
      "Do a quick tidying task to feel more in control.",
    ],
    '😴': [
      "Consider a short nap if possible.",
      "Get some fresh air and sunlight.",
    ],
    '🥳': ["Share your joy with someone!", "Reflect on what made you happy."],
    '😥': ["Allow yourself to feel the emotion.", "Practice self-compassion."],
    '😎': ["Continue what you're doing!", "Set a small, achievable goal."],
  };

  void _selectMood(String mood) {
    setState(() {
      _selectedMood = mood;
      _suggestions = _moodToActionMap[mood] ?? ["No specific suggestions yet."];
    });
    _showSuggestionsPopup(context);
  }

  void _showSuggestionsPopup(BuildContext context) {
    if (_selectedMood == null || _suggestions.isEmpty) {
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Suggestions for ${_selectedMood!}:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              if (_suggestions.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = _suggestions[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        title: Text(suggestion),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => _performAction(suggestion),
                      ),
                    );
                  },
                )
              else
                Text('No specific suggestions found for this mood.'),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _performAction(String action) {
    // Implement the actual action based on the suggestion
    print('Performing action: $action');
    if (action.toLowerCase().contains("breathing game")) {
      _startBreathingGame(context);
    } else if (action.toLowerCase().contains("hide notifications")) {
      _hideNotifications();
    } else {
      // Handle other actions or provide feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Action "$action" initiated (placeholder)')),
      );
    }
  }

  void _startBreathingGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BreathingGameScreen()),
    );
  }

  void _hideNotifications() {
    // Implement platform-specific code to hide notifications
    // This might require using platform channels or specific plugins
    print('Attempting to hide notifications...');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notifications hiding (placeholder)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mood to Action')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'How are you feeling?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _moodToActionMap.keys.length,
              itemBuilder: (context, index) {
                final mood = _moodToActionMap.keys.toList()[index];
                return InkWell(
                  onTap: () => _selectMood(mood),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          _selectedMood == mood
                              ? Colors.blue[100]
                              : Colors.grey[200],
                    ),
                    child: Center(
                      child: Text(mood, style: TextStyle(fontSize: 30)),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 24),
            if (_selectedMood != null)
              Text(
                'You selected: ${_selectedMood!}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 8),
            if (_selectedMood != null)
              Text(
                'Tap an emoji to see suggestions.',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
          ],
        ),
      ),
    );
  }
}

class BreathingGameScreen extends StatelessWidget {
  const BreathingGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('2-Minute Breathing Game')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Focus on your breath.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Implement your breathing game UI and logic here
              Text(
                '(Breathing animation/instructions would go here)',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Done'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

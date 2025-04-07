import 'package:flutter/material.dart';

class Settings {
  String? name;
  int? age;
  String? disorder;
  // Add other settings as needed

  Settings({this.name, this.age, this.disorder});

  // You can add methods to save and load settings if needed.
  // For example, using shared_preferences:
  /*
  Future<void> saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    if (name != null) {
      await prefs.setString('name', name!);
    }
    if (age != null) {
      await prefs.setInt('age', age!);
    }
     if (disorder != null) {
      await prefs.setString('disorder', disorder!);
    }
    // Save other settings
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    age = prefs.getInt('age');
    disorder = prefs.getString('disorder');
    // Load other settings
  }
  */
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _disorderController = TextEditingController();
  final Settings _settings = Settings();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _disorderController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadSettings(); // Load saved settings when the screen initializes
  }

  // Load Settings
  Future<void> _loadSettings() async {
    // Example of loading settings (you'll need shared_preferences)
    // In a real app, use a service class to manage shared preferences
    /*
    await _settings.loadSettings();
    setState(() {
      _nameController.text = _settings.name ?? '';
      _ageController.text = _settings.age?.toString() ?? '';
      _disorderController.text = _settings.disorder ?? '';
    });
    */
    //For now, I will initialize the controllers with empty strings
    setState(() {
      _nameController.text = '';
      _ageController.text = '';
      _disorderController.text = '';
    });
  }

  // Save Settings
  Future<void> _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      _settings.name = _nameController.text;
      _settings.age = int.tryParse(_ageController.text);
      _settings.disorder = _disorderController.text;
      // Example of saving settings (you'll need shared_preferences)
      // await _settings.saveSettings(); // Use the method in the Settings class
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Settings saved successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Invalid age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _disorderController,
                decoration: InputDecoration(labelText: 'Disorder'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your disorder';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveSettings,
                child: Text('Save Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LinkScreenLayout extends StatefulWidget {
  const LinkScreenLayout({super.key});

  @override
  _LinkScreenLayoutState createState() => _LinkScreenLayoutState();
}

class _LinkScreenLayoutState extends State<LinkScreenLayout> {
  final TextEditingController _firstTextFieldController = TextEditingController();
  final TextEditingController _secondTextFieldController = TextEditingController();
  String _displayedText = '';

  void _saveText() {
    setState(() {
      _displayedText = _secondTextFieldController.text;
    });
  }

  @override
  void dispose() {
    _firstTextFieldController.dispose();
    _secondTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Link Screen Layout'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _displayedText,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _firstTextFieldController,
                decoration: InputDecoration(
                  labelText: 'https://rt.pornhub.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _secondTextFieldController,
                decoration: InputDecoration(
                  labelText: 'Second Text Field',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveText,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'widgets/question_modal.dart';

class QuizScreenLayout extends StatefulWidget {
  const QuizScreenLayout({super.key, required this.titleAppBar});

  final String titleAppBar;

  @override
  State<QuizScreenLayout> createState() => _QuizScreenLayoutState();
}

class _QuizScreenLayoutState extends State<QuizScreenLayout> {
  final TextEditingController _contentController = TextEditingController();
  String _displayText = '';
  final List<String> _questions = [];

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _saveText() {
    setState(() {
      _displayText = _contentController.text;
      _contentController.clear();
    });
  }

  void _cancelText() {
    setState(() {
      _contentController.clear();
    });
  }

  void _addQuestion(String question) {
    setState(() {
      _questions.add(question);
    });
  }

  void _showQuestionModal() {
    showDialog(
      context: context,
      builder: (context) {
        return QuestionModal(onSave: _addQuestion);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const sb = SizedBox(height: 24);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleAppBar),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sb,
            TextField(
              minLines: 1,
              maxLines: 12,
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'Write the text',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            sb,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: _saveText,
                  child: const Text('Save'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _cancelText,
                  child: const Text('Cancel'),
                ),
              ],
            ),
            sb,
            const Divider(height: 1),
            sb,
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(_displayText),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_questions[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showQuestionModal,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

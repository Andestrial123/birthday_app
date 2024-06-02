import 'package:admin/constans/const.dart';
import 'package:flutter/material.dart';
class QuestionModal extends StatelessWidget {
  final Function(String) onSave;
  final String title;

  QuestionModal({required this.onSave, required this.title});

  @override
  Widget build(BuildContext context) {
    final TextEditingController questionController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            sbH24,
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                hintText: 'Write the question',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
            ),
            sbH24,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    onSave(questionController.text);
                    questionController.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
                sbW16,
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

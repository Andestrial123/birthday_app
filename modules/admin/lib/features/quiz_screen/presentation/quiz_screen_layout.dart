import 'package:admin/constans/const.dart';
import 'package:admin/features/main_screen/domain/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/base_model.dart';
import 'package:shared/models/quiz_model/quiz_model.dart';

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
  final List<Answers> _questions = [];

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
      _questions.add(Answers(title: question, isCorrect: false));
    });
  }

  void _editQuestion(int index, String newQuestion) {
    setState(() {
      _questions[index].setTitle(newQuestion);
    });
  }

  void _deleteQuestion(int index) {
    setState(() {
      _questions.removeAt(index);
    });
  }

  void _toggleCheckbox(int index) {
    setState(() {
      _questions[index].setIsCorrect(!_questions[index].isCorrect!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleAppBar),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
              onPressed: () {
                context.read<MainCubit>().sendQuizEvent(BaseModel(
                    challengeType: ChallengeType.quiz,
                    data: QuizModel(
                      question: _displayText,
                      answers: _questions,
                    ).toJson()));
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Write your question',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            sbH24,
            TextField(
              minLines: 1,
              maxLines: 12,
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'Add a question',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            sbH24,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: _saveText,
                  child: const Text('Save'),
                ),
                sbW16,
                ElevatedButton(
                  onPressed: _cancelText,
                  child: const Text('Cancel'),
                ),
              ],
            ),
            sbH24,
            const Divider(height: 1),
            sbH24,
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    _displayText,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            sbH24,
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  final question = _questions[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: question.isCorrect!
                          ? Colors.green.withOpacity(0.2)
                          : Colors.transparent,
                      border: Border.all(
                        color: question.isCorrect! ? Colors.green : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: question.isCorrect!,
                          onChanged: (bool? value) {
                            _toggleCheckbox(index);
                          },
                        ),
                        Expanded(
                          child: Text(question.title ?? ""),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditQuestionModal(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _deleteQuestion(index);
                          },
                        ),
                      ],
                    ),
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

  void _showQuestionModal() {
    showDialog(
      context: context,
      builder: (context) {
        return QuestionModal(onSave: _addQuestion, title: 'Add a question');
      },
    );
  }

  void _showEditQuestionModal(int index) {
    final TextEditingController editController =
        TextEditingController(text: _questions[index].title);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Text(
                    'Edit Question',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                sbH24,
                TextField(
                  controller: editController,
                  decoration: const InputDecoration(
                    hintText: 'Edit the text',
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
                        _editQuestion(index, editController.text);
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
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared/models/quiz_model/quiz_model.dart';

class QuizWidget extends StatefulWidget {
  final QuizModel data;
  final Function(Answers) onSubmit;

  const QuizWidget({super.key, required this.data, required this.onSubmit});

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late Answers selectedModel = Answers();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.data.question ?? ""),
        ...?widget.data.answers?.map((element) {
          return Row(
            children: [
              Radio<Answers>(
                  value: element,
                  groupValue: selectedModel,
                  onChanged: (value) {
                    setState(() {
                      selectedModel = value!;
                    });
                  }),
              Text(element.title!)
            ],
          );
        }),
        const Spacer(),
        ElevatedButton(
            onPressed: () => widget.onSubmit(selectedModel),
            child: const Text("Send answer"))
      ],
    );
  }
}

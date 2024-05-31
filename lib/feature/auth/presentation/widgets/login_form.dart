import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginFormWidget extends StatefulWidget {
  final Function(String) onSend;

  const LoginFormWidget({super.key, required this.onSend});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Spacer(),
          AnimatedTextField(
            controller: _phoneTextController,
            animationType: Animationtype.typer,
            textAlign: TextAlign.center,
            hintTextAlign: TextAlign.center,
            hintTextStyle: const TextStyle(
              color: Colors.deepPurple,
              overflow: TextOverflow.ellipsis,
            ),
            hintTexts: const [
              '\t\t\t\t\t\t\t\t\t\t\t\t\tEnter your phone number',
              '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tDOG!',
              '\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tTAP ON ME!!!'
            ],
            decoration: const InputDecoration(
              border: InputBorder.none,
              // filled: true,
              contentPadding: EdgeInsets.all(12),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(13),
            ],
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                if (_phoneTextController.text.length == 13) {
                  widget.onSend(_phoneTextController.text);
                }
              },
              child: const Text("Send me OTP"))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPWidget extends StatefulWidget {
  final Function(String) onSend;
  final Function() onBack;

  const OTPWidget({super.key, required this.onSend, required this.onBack});

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Spacer(),
          OtpTextField(
            numberOfFields: 6,
            showFieldAsBox: true,
            onSubmit: (String verificationCode) {
              widget.onSend(verificationCode);
            },
          ),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                widget.onBack();
              },
              child: const Text("Go back"))
        ],
      ),
    );
  }
}

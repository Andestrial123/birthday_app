library admin;

import 'package:flutter/material.dart';

/// A Calculator.
class AdminMainPage extends StatelessWidget {
  final Function() onLogout;

  const AdminMainPage({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Hello i'm Admin"),
        const Spacer(),
        ElevatedButton(onPressed: onLogout, child: const Text("Logout"))
      ],
    );
  }
}

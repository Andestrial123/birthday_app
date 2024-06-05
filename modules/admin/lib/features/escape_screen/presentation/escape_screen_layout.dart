import 'package:admin/features/main_screen/domain/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/base_model.dart';
import 'package:shared/models/escape_model/escape_model.dart';
import 'package:shared/models/spawn_model/spawn_model.dart';

class EscapeScreenLayout extends StatefulWidget {
  const EscapeScreenLayout({super.key});

  @override
  EscapeScreenLayoutState createState() => EscapeScreenLayoutState();
}

class EscapeScreenLayoutState extends State<EscapeScreenLayout> {
  final TextEditingController _countTextFieldController =
  TextEditingController();

  void _sendEvent() {
    context.read<MainCubit>().sendLinkEvent(BaseModel(
        challengeType: ChallengeType.escapeButton,
        data: EscapeModel(
          int.parse(_countTextFieldController.text)
        ).toJson()));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _countTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escape Screen Layout'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                controller: _countTextFieldController,
                decoration: InputDecoration(
                  labelText: 'How escapes after click',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _sendEvent,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

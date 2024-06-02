import 'package:admin/features/main_screen/domain/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/models/base_model.dart';
import 'package:shared/models/link_model/link_model.dart';

class LinkScreenLayout extends StatefulWidget {
  const LinkScreenLayout({super.key});

  @override
  LinkScreenLayoutState createState() => LinkScreenLayoutState();
}

class LinkScreenLayoutState extends State<LinkScreenLayout> {
  final TextEditingController _titleTextFieldController =
      TextEditingController();
  final TextEditingController _linkTextFieldController =
      TextEditingController();

  void _saveText() {
    context.read<MainCubit>().sendLinkEvent(BaseModel(
        challengeType: ChallengeType.funnyLink,
        data: LinkModel(
          link: _linkTextFieldController.text,
          title: _titleTextFieldController.text,
        ).toJson()));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleTextFieldController.dispose();
    _linkTextFieldController.dispose();
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
              const SizedBox(height: 16),
              TextField(
                controller: _linkTextFieldController,
                decoration: InputDecoration(
                  labelText: 'https://rt.pornhub.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleTextFieldController,
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

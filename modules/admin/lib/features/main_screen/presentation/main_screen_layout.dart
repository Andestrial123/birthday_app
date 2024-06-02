import 'package:admin/constans/const.dart';
import 'package:admin/features/quiz_screen/presentation/quiz_screen_layout.dart';
import 'package:flutter/material.dart';

class MainScreenLayout extends StatelessWidget {
  const MainScreenLayout({super.key, required this.titleAppBar});

  final String titleAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBar),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SizedBox(
          height: 250,
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QuizScreenLayout(
                                    titleAppBar: 'Quiz Screen',
                                  )));
                    },
                    child: const Text('Add quiz')),
                sbH24,
                ElevatedButton(
                    onPressed: () {}, child: const Text('Add map point')),
                sbH24,
                ElevatedButton(
                    onPressed: () {},
                    child: const Text('Add link with comment')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

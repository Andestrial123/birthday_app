import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/features/main/domain/main_cubit.dart';
import 'package:user/features/main/presentation/widgets/incorrect_widget.dart';
import 'package:user/features/main/presentation/widgets/map_util.dart';
import 'package:user/features/main/presentation/widgets/quiz_widget.dart';
import 'package:volume_control/volume_control.dart';

import '../data/db/db.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (context) => MainCubit(db),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (BuildContext context, state) {
            return switch (state) {
              MainInitial() => const Center(child: Text("Alloha, Ожидай)))")),
              MainQuizState(data: var data) => QuizWidget(
                  data: data,
                  onSubmit: (answer) {
                    context
                        .read<MainCubit>()
                        .submitQuizAnswer(answer.isCorrect!);
                  },
                ),
              MainCorrectState() => Center(
                  child: AnimatedTextField(
                    readOnly: true,
                    animationType: Animationtype.typer,
                    textAlign: TextAlign.center,
                    hintTextAlign: TextAlign.center,
                    hintTexts: const [
                      "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tУмничка)"
                    ],
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      // filled: true,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  ),
                ),
              MainIncorrectState(badMove: var badMove) => IncorrectWidget(
                  title: badMove,
                  onDone: () {
                    context.read<MainCubit>().resetState();
                  },
                ),
              MainLinkState(data: var data) => Center(
                  child: Column(
                    children: [
                      Text(data.title ?? ""),
                      IconButton(
                          onPressed: () async {
                            await VolumeControl.setVolume(1);
                            await launchUrl(Uri.parse(data.link!));
                            if (context.mounted) {
                              context.read<MainCubit>().resetState();
                            }
                          },
                          icon: const Icon(Icons.accessibility))
                    ],
                  ),
                ),
              MainMapState(data: var data) => Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        await MapUtils.openMap(
                            double.parse(data.coords?.split(",").first ?? ""),
                            double.parse(data.coords?.split(",").last ?? ""));
                        if (context.mounted) {
                          context.read<MainCubit>().resetState();
                        }
                      },
                      child: const Text("Click me")),
                )
            };
          },
        ));
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/main_cubit.dart';

class IncorrectWidget extends StatefulWidget {
  final String title;
  final Function() onDone;

  const IncorrectWidget({super.key, required this.title, required this.onDone});

  @override
  State<IncorrectWidget> createState() => _IncorrectWidgetState();
}

class _IncorrectWidgetState extends State<IncorrectWidget> {
  late final Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 10), () {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(widget.title),
        const Spacer(),
        ElevatedButton(
            onPressed: () {
              if (_timer.isActive) {
                context.read<MainCubit>().emit(
                    MainIncorrectState("Ти кого наебать решил? Х3 от норми"));
              } else {
                widget.onDone();
              }
            },
            child: const Text("Сделяль"))
      ],
    );
  }
}

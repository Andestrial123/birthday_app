import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared/models/spawn_model/spawn_model.dart';

class SpawnButtonsWidget extends StatefulWidget {
  final SpawnModel model;
  final Function() onTap;

  const SpawnButtonsWidget(
      {super.key, required this.model, required this.onTap});

  @override
  State<SpawnButtonsWidget> createState() => _SpawnButtonsWidgetState();
}

class _SpawnButtonsWidgetState extends State<SpawnButtonsWidget> {
  late List<Widget> buttonsList = [];

  var r = Random();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _drawButtons();
    });
    super.initState();
  }

  void _drawButtons() {
    for (int i = 0; i <= widget.model.count!; i++) {
      var screenWidth = MediaQuery.of(context).size.width - 100;
      var screenHeight = MediaQuery.of(context).size.height - 100;

      var randomX = r.nextInt(screenWidth.toInt());
      var randomY = r.nextInt(screenHeight.toInt());

      buttonsList.add(Positioned(
          key: ValueKey("button$i"),
          top: randomY.toDouble(),
          left: randomX.toDouble(),
          child: ElevatedButton(
            onPressed: () {
              if (buttonsList.length == 1) {
                widget.onTap.call();
              }
              setState(() {
                buttonsList.removeWhere(
                    (element) => element.key == ValueKey("button$i"));
              });
            },
            child: const Text("Тицяй"),
          )));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: buttonsList,
      ),
    );
  }
}

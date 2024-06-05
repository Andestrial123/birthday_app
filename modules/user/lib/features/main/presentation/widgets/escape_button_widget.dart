import 'dart:math';

import 'package:flutter/material.dart';

class EscapeButtonWidget extends StatefulWidget {
  final Function() onTap;
  final int count;

  const EscapeButtonWidget(
      {super.key, required this.onTap, required this.count});

  @override
  State<EscapeButtonWidget> createState() => _EscapeButtonWidgetState();
}

class _EscapeButtonWidgetState extends State<EscapeButtonWidget> {
  var r = Random();

  var counter = 0;

  Color baseColor = Colors.white;

  @override
  void initState() {
    super.initState();
  }

  final titlesList = [
    "Неа",
    "Мимо",
    "Все еще не",
    "Не то",
    "Димочка мальчик мой\n Иди нахуй",
    "Почти!",
    "А не пизжу",
    "Как день ?",
    "Тицяй",
    "Хи-хи",
    "Пизда пингвина!",
  ];

  @override
  Widget build(BuildContext context) {
    final title = titlesList[r.nextInt(titlesList.length)];
    var screenWidth = MediaQuery.of(context).size.width - title.length * 12;
    var screenHeight = MediaQuery.of(context).size.height - 100;

    var randomX = r.nextInt(screenWidth.toInt());
    var randomY = r.nextInt(screenHeight.toInt());

    return Stack(
      children: [
        Positioned(
            top: randomY.toDouble(),
            left: randomX.toDouble(),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
                if (counter == widget.count) {
                  widget.onTap.call();
                }
              },
              child: Text(
                title,
                textAlign: TextAlign.center,
              ),
            )),
      ],
    );
  }
}

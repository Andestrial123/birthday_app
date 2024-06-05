import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class WhitePixelWidget extends StatefulWidget {
  final Function() onTap;

  const WhitePixelWidget({super.key, required this.onTap});

  @override
  State<WhitePixelWidget> createState() => _WhitePixelWidgetState();
}

class _WhitePixelWidgetState extends State<WhitePixelWidget> {
  final _random = Random();

  late final topSide =
      (_random.nextInt(MediaQuery.sizeOf(context).height.toInt())).toDouble();

  late final leftSide =
      (_random.nextInt(MediaQuery.sizeOf(context).width.toInt())).toDouble();

  Color baseColor = Colors.white;

  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      setState(() {
        baseColor = const Color.fromRGBO(245, 245, 245, 1);
      });
      await Future.delayed(const Duration(milliseconds: 400));
      setState(() {
        baseColor = Colors.white;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: topSide,
            left: leftSide,
            child: GestureDetector(
              onTap: () {
                widget.onTap.call();
                if (_timer.isActive) {
                  _timer.cancel();
                }
              },
              child: Container(
                width: 5,
                height: 5,
                color: baseColor,
              ),
            )),
        Positioned(
          child: Text("$topSide,$leftSide"),
        )
      ],
    );
  }
}

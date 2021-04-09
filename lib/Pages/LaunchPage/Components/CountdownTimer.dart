import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Utils/CountDown.dart';
import 'package:spaceportal/Utils/Functions.dart';

class CountdownTimer extends StatefulWidget {
  final String time;
  CountdownTimer({required this.time});
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  @override
  Widget build(BuildContext context) {
    return Countdown(
      duration: timeDifference(widget.time),
      onFinish: () => print('finished'),
      builder: (context, remaining) {
        return AutoSizeText(
          '-${remaining.toString().split('.')[0]} HMS',
          style: kCardTS.copyWith(
            fontSize: 15,
          ),
        );
      },
    );
  }
}

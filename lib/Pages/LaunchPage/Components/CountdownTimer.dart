import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Utils/CountDown.dart';

class CountdownTimer extends StatefulWidget {
  final String time;
  CountdownTimer({required this.time});
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  String timer = '';
  StreamSubscription? sub;

  Duration timeDifference(String time) {
    DateTime currentDateTime = DateTime.now();
    DateTime parsedDate = DateTime.parse(time);
    return currentDateTime.difference(parsedDate).abs();
  }

  StreamSubscription timeUpdate() {
    var diff = timeDifference(widget.time);

    CountDown cd = CountDown(diff);
    return cd.stream.listen(null);
  }


  @override
  void initState() {
    super.initState();
    sub = timeUpdate();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sub?.onData((data) {
      setState(() {
        timer = data.toString().split('.')[0];
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    sub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AutoSizeText(
        '-' + timer + ' HMS',
        textAlign: TextAlign.center,
        style: kCardTS.copyWith(
          fontSize: 15,
        ),
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
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
  /// Converts a duration into DHMS format.
  String _formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('${days}d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('${hours}h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('${minutes}m');
    }
    tokens.add('${seconds}s');

    return tokens.join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      duration: timeDifference(widget.time),
      onFinish: () => print('finished'),
      builder: (context, remaining) {
        return AutoSizeText(
          'T -${_formatDuration(remaining)}',
          textAlign: TextAlign.right,
          style: kCardTS.copyWith(
            fontSize: 15,
            shadows: null,
          ),
        );
      },
    );
  }
}

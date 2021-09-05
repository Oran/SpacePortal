import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/models/launch_model.dart';
import 'package:spaceportal/pages/launch_page/components/countdown_timer.dart';

class CountdownTimerText extends StatelessWidget {
  const CountdownTimerText({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final Launches data;
  final int index;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // color: Colors.grey[300],
        border: Border.all(
          width: 1,
          color: theme.accentColor,
        ),
      ),
      height: (MediaQuery.of(context).size.height) * 0.10,
      width: (MediaQuery.of(context).size.width) * 0.60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            'Countdown:',
            style: theme.textTheme.bodyText2,
          ),
          SizedBox(height: 5),
          CountdownTimer(
            time: data.launchData[index].net,
            style: theme.textTheme.headline5,
          )
        ],
      ),
    );
  }
}

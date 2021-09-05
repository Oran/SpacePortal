import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MarsRoverImageStats extends StatelessWidget {
  MarsRoverImageStats({required this.text1, required this.text2});

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$text1',
            style: theme.textTheme.bodyText2,
          ),
          AutoSizeText(
            '$text2',
            maxLines: 1,
            maxFontSize: 27,
            style: theme.textTheme.headline5,
          ),
        ],
      ),
    );
  }
}

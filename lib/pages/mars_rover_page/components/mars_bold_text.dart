import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MarsBoldText extends StatelessWidget {
  const MarsBoldText({
    required this.text1,
    required this.text2,
  });

  final String? text1;
  final String? text2;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AutoSizeText.rich(
      TextSpan(
        text: text1,
        style: theme.textTheme.subtitle1,
        children: [
          TextSpan(
            text: text2,
            style: theme.textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

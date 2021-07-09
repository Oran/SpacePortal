import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/constants.dart';

class MarsBoldText extends StatelessWidget {
  const MarsBoldText({
    required this.text1,
    required this.text2,
  });

  final String? text1;
  final String? text2;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText.rich(
      TextSpan(
        text: text1,
        style: kDetailsTS.copyWith(fontSize: 17),
        children: [
          TextSpan(
            text: text2,
            style: kDetailsTS.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }
}
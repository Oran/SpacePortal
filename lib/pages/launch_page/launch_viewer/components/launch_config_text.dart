import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class LunchConfigText extends StatelessWidget {
  const LunchConfigText({
    Key? key,
    required this.text1,
    required this.text2,
    this.height,
    this.width,
    this.onTap,
  }) : super(key: key);

  final String text1;
  final String text2;
  final double? height;
  final double? width;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: Colors.grey[300],
          border: Border.all(
            width: 1,
            color: theme.accentColor,
          ),
        ),
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              text1,
              style: theme.textTheme.bodyText2,
            ),
            SizedBox(height: 5),
            AutoSizeText(
              text2,
              style: theme.textTheme.headline5,
              minFontSize: 25,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

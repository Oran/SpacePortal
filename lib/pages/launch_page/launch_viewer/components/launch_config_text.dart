import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spaceportal/constants.dart';

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
            color: Colors.black,
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
              style: kDetailsTS,
            ),
            AutoSizeText(
              text2,
              style: GoogleFonts.roboto(
                fontSize: 29,
                fontWeight: FontWeight.w900,
                // color: checkAbbrev()
              ),
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

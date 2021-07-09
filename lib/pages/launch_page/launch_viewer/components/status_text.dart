import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spaceportal/constants.dart';
import 'package:spaceportal/models/launch_model.dart';

class StatusText extends StatefulWidget {
  const StatusText({
    Key? key,
    required this.data,
    required this.index,
    this.onTap,
  }) : super(key: key);

  final Launches data;
  final int index;
  final VoidCallback? onTap;

  @override
  _StatusTextState createState() => _StatusTextState();
}

class _StatusTextState extends State<StatusText> {
  Color checkAbbrev(String abbrev) {
    var defaultColor = Color.fromRGBO(0, 0, 0, 0);
    if (abbrev == 'Go') {
      setState(() {
        defaultColor = Color.fromRGBO(85, 218, 112, 1.0);
      });
    }

    if (abbrev == 'TBC') {
      setState(() {
        defaultColor = Color.fromRGBO(85, 161, 218, 1.0);
      });
    }

    if (abbrev == 'TBD') {
      setState(() {
        defaultColor = Color.fromRGBO(85, 161, 218, 1.0);
      });
    }

    if (abbrev == 'TBD') {
      setState(() {
        defaultColor = Color.fromRGBO(85, 161, 218, 1.0);
      });
    }

    return defaultColor;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: checkAbbrev(
          //   widget.data.launchData[widget.index].status.abbrev,
          // ),
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        height: (MediaQuery.of(context).size.height) * 0.10,
        width: (MediaQuery.of(context).size.width) * 0.245,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  'Status:',
                  style: kDetailsTS,
                ),
                AutoSizeText(
                  widget.data.launchData[widget.index].status.abbrev,
                  style: GoogleFonts.roboto(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    // color: checkAbbrev()
                  ),
                ),
              ],
            ),
            Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: checkAbbrev(
                  widget.data.launchData[widget.index].status.abbrev,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

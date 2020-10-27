import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompassCircle extends StatelessWidget {
  final Widget child;
  CompassCircle({this.child});

  final TextStyle _textStyle = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff11194B),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          Positioned(
            left: 190.0,
            top: 10.0,
            child: Text(
              'N',
              style: _textStyle,
            ),
          ),
          Positioned(
            left: 190.0,
            top: 235.0,
            child: Text(
              'S',
              style: _textStyle,
            ),
          ),
          Positioned(
            left: 304.0,
            top: 120.0,
            child: Text(
              'W',
              style: _textStyle,
            ),
          ),
          Positioned(
            left: 75.0,
            top: 120.0,
            child: Text(
              'E',
              style: _textStyle,
            ),
          ),
          Center(child: child),
        ],
      ),
    );
  }
}

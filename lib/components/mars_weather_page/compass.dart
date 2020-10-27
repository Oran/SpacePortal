import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompassCircle extends StatelessWidget {
  final Widget child;
  CompassCircle({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Color(0xff11194B),
        shape: BoxShape.circle,
      ),
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/svgs/compass.svg',
            fit: BoxFit.contain,
          ),
          Center(child: child),
        ],
      ),
    );
  }
}

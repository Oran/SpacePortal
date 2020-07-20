import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 144,
        height: 145,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 22.2857666015625,
              child: Container(
                width: 121.71428680419922,
                height: 95.21592712402344,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color.fromRGBO(202, 187, 173, 1),
                ),
              ),
            ),
            Positioned(
              top: 39.776611328125,
              left: 0,
              child: Container(
                width: 110.70346069335938,
                height: 86.69548797607422,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color.fromRGBO(196, 196, 196, 1),
                ),
              ),
            ),
            Positioned(
              top: 76.62347412109375,
              left: 40.040771484375,
              child: Container(
                width: 86.30108642578125,
                height: 68.37654113769531,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Color.fromRGBO(162, 162, 162, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

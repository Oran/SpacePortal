import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DCard extends StatelessWidget {
  DCard({
    @required this.image,
    this.onPressed,
    this.text = '',
  });
  final String image;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: (MediaQuery.of(context).size.height) * 0.80,
            width: (MediaQuery.of(context).size.width) * 0.90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 10,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height),
                      width: (MediaQuery.of(context).size.width),
                      // child: Image(
                      //   alignment: Alignment.topCenter,
                      //   image: image,
                      //   fit: BoxFit.cover,
                      // ),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 300.0,
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        height: 300.0,
                        width: 230.0,
                        alignment: Alignment.bottomCenter,
                        child: Center(
                          //TODO: Better TextStyle / Fonts
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

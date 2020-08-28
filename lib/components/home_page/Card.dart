import 'package:flutter/material.dart';
import 'package:SpacePortal/constants.dart';

class DCard extends StatelessWidget {
  DCard({
    this.image,
    this.onPressed,
    this.text = '',
  });
  //A widget because you need to use cachedNetworkImage
  final Widget image;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: (MediaQuery.of(context).size.height) * 0.30,
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
                      child: image,
                    ),
                    Positioned(
                      top: 70.0,
                      left: 10.0,
                      child: Container(
                        // color: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        height: 150.0,
                        width: 300.0,
                        alignment: Alignment.bottomCenter,
                        child: Center(
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: kCardTS,
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

class WeatherCard extends StatelessWidget {
  WeatherCard({
    this.image,
    this.onPressed,
    this.text = '',
  });
  //A widget because you need to use cachedNetworkImage
  final Widget image;
  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          height: 200.0,
          width: 200.0,
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
            child: Center(
              child: Stack(
                children: [
                  Container(
                    height: (MediaQuery.of(context).size.height),
                    width: (MediaQuery.of(context).size.width),
                    child: Image.asset(
                      'assets/images/mars_insight.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Text(
                      text,
                      style: kCardTS.copyWith(
                        fontSize: 55.0,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150.0,
                    left: 28.0,
                    child: Text(
                      'Mars Weather',
                      style: kCardTS.copyWith(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

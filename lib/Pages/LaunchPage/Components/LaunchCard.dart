import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Pages/LaunchPage/Components/CountdownTimer.dart';

class LaunchCard extends StatelessWidget {
  LaunchCard({
    this.image,
    this.onPressed,
    this.text = '',
    this.date = '',
  });
  //A widget because you need to use cachedNetworkImage
  final Widget? image;
  final Function? onPressed;
  final String? text;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: (MediaQuery.of(context).size.height) * 0.30,
            width: (MediaQuery.of(context).size.width) * 0.90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
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
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height),
                      width: (MediaQuery.of(context).size.width),
                      // alignment: Alignment.centerLeft,
                      child: image,
                    ),
                    Positioned(
                      left: (MediaQuery.of(context).size.width) * 0.3,
                      child: Container(
                        height: (MediaQuery.of(context).size.height),
                        width: (MediaQuery.of(context).size.height) * 0.3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 145.0,
                      left: 90.0,
                      child: Container(
                        // color: Colors.white,
                        padding: EdgeInsets.all(15.0),
                        height: 150.0,
                        width: 300.0,
                        alignment: Alignment.bottomCenter,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AutoSizeText(
                                date!,
                                textAlign: TextAlign.center,
                                style: kCardTS.copyWith(
                                  fontSize: 15,
                                ),
                                maxLines: 3,
                              ),
                              // AutoSizeText(
                              //   parseDateAndTime(convertDateToLocal(date!))[0],
                              //   textAlign: TextAlign.center,
                              //   style: kCardTS.copyWith(
                              //     fontSize: 15,
                              //   ),
                              //   maxLines: 3,
                              // ),
                              CountdownTimer(time: date!),
                            ],
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

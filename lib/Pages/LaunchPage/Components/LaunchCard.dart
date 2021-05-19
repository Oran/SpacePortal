import 'dart:ui';

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
            height: (MediaQuery.of(context).size.height) * 0.25,
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
                      child: image,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.60),
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black,
                              Colors.black,
                              Colors.black,
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(15.0),
                        height: (MediaQuery.of(context).size.height) * 0.12,
                        width: (MediaQuery.of(context).size.width) * 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AutoSizeText(
                              text!,
                              textAlign: TextAlign.right,
                              style: kCardTS.copyWith(
                                fontSize: 18,
                                shadows: null,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5),
                            AutoSizeText(
                              date!.toString().split('T')[0],
                              textAlign: TextAlign.right,
                              style: kCardTS.copyWith(
                                fontSize: 15,
                                shadows: null,
                              ),
                              maxLines: 3,
                            ),
                            SizedBox(height: 5),
                            CountdownTimer(time: date!),
                          ],
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

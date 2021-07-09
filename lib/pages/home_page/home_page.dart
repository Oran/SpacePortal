import 'package:flutter/material.dart';
import 'package:spaceportal/constants.dart';
import 'package:spaceportal/pages/home_page/components/card_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: (MediaQuery.of(context).size.width),
        height: (MediaQuery.of(context).size.height),
        child: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10.0),
                child: Text(
                  'Welcome',
                  style: kTitleLargeTS,
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: (MediaQuery.of(context).size.height),
                  child: CardView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

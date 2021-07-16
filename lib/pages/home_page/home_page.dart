import 'package:flutter/material.dart';
import 'package:spaceportal/constants.dart';
import 'package:spaceportal/pages/home_page/components/card_view.dart';
import 'package:theme_provider/theme_provider.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      'Welcome',
                      style: kTitleLargeTS,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        ThemeProvider.controllerOf(context).nextTheme();
                      },
                      child: Icon(Icons.palette_rounded),
                    ),
                  )
                ],
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

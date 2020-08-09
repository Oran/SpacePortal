import 'package:SpacePortal/components/card.dart';
import 'package:SpacePortal/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//To Remove the overscroll indicator
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Map>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Welcome',
                  style: kTitleLargeTS,
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      DCard(
                        image: CachedNetworkImage(
                          imageUrl: data['image'],
                          fit: BoxFit.cover,
                        ),
                        text: data['title'],
                        onPressed: () =>
                            Navigator.pushNamed(context, kNASAPod_Page),
                      ),
                      DCard(
                        image: Image.asset(
                          'assets/images/mars_rover.jpg',
                          fit: BoxFit.cover,
                        ),
                        text: 'Mars Rover Images',
                        onPressed: () =>
                            Navigator.pushNamed(context, kMars_Page),
                      ),
                      DCard(
                        image: Image.asset(
                          'assets/images/falcon_nine.jpg',
                          fit: BoxFit.cover,
                        ),
                        text: data['title'],
                        onPressed: () =>
                            Navigator.pushNamed(context, kSpaceX_Page),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

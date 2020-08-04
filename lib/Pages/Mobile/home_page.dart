import 'package:SpacePortal/components/Card.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//To Remove the overscroll indicator
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  var box = Hive.box('cache');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey[100],
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: 60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: MyBehavior(),
                  child: PageView(
                    controller: _pageController,
                    physics: PageScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      DCard(
                        text: box.get('title'),
                        image: box.get('image'),
                      ),
                      DCard(
                        image:
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/NASA_Mars_Rover.jpg/1125px-NASA_Mars_Rover.jpg',
                        text: 'Mars Rover Images',
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

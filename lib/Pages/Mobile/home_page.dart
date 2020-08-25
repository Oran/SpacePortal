import 'package:SpacePortal/components/home_page/mars_weather_card.dart';
import 'package:SpacePortal/network/models.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/components/home_page/card.dart';
import 'package:SpacePortal/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    try {
      Timer.periodic(Duration(seconds: 5), (timer) {
        if (_currentPage < 2) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOutCirc,
          );
        }
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<FSData>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(top: 30.0),
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
                child: PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: [
                    DCard(
                      image: CachedNetworkImage(
                        imageUrl: data.image,
                        fit: BoxFit.cover,
                      ),
                      text: data.title,
                      onPressed: () =>
                          Navigator.pushNamed(context, kNASAPod_Page),
                    ),
                    DCard(
                      image: Image.asset(
                        'assets/images/mars_rover.jpg',
                        fit: BoxFit.cover,
                      ),
                      text: 'Mars Rover Images',
                      onPressed: () => Navigator.pushNamed(context, kMars_Page),
                    ),
                    DCard(
                      image: Image.asset(
                        'assets/images/falcon_nine.jpg',
                        fit: BoxFit.cover,
                      ),
                      text: 'SpaceX Upcoming launches',
                      onPressed: () =>
                          Navigator.pushNamed(context, kSpaceX_Page),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Mars Weather',
                        style: kWeatherCardTS,
                        textScaleFactor: 1.1,
                      ),
                    ),
                    Container(
                      height: (MediaQuery.of(context).size.height) * 0.49,
                      width: (MediaQuery.of(context).size.width),
                      child: MarsWeatherCard(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

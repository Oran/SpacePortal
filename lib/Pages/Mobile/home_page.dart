import 'package:SpacePortal/components/home_page/Card.dart';
import 'package:SpacePortal/providers.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Scaffold(
      body: Container(
        width: double.infinity,
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
              Container(
                height: (MediaQuery.of(context).size.height) * 0.727,
                child: ListView(
                  // controller: _pageController,
                  // scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    Consumer(
                      builder: (context, watch, child) {
                        var apodProviderData = watch(apodProvider);
                        return apodProviderData.when(
                          data: (data) => DCard(
                            image: CachedNetworkImage(
                              imageUrl: data.image,
                              fit: BoxFit.cover,
                            ),
                            text: data.title,
                            onPressed: () =>
                                Navigator.pushNamed(context, kNASAPod_Page),
                          ),
                          loading: () => Container(color: Colors.black),
                          error: (error, stack) => const Text('Oops'),
                        );
                      },
                    ),
                    DCard(
                      image: Image.asset(
                        'assets/images/mars_rover.jpg',
                        fit: BoxFit.cover,
                      ),
                      text: 'Mars Rover Images',
                      onPressed: () => Navigator.pushNamed(context, kMars_Page),
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

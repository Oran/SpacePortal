import 'package:SpacePortal/Pages/TestPage.dart';
import 'package:SpacePortal/Pages/HomePage/Components/Card.dart';
import 'package:SpacePortal/Providers/Providers.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
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
                              imageUrl: data.image!,
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
                    DCard(
                      image: Container(color: Colors.black),
                      text: 'TEST PAGE',
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TestPage(),
                        ),
                      ),
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

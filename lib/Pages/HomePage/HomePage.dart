import 'package:spaceportal/Pages/TestPage.dart';
import 'package:spaceportal/Pages/HomePage/Components/Card.dart';
import 'package:spaceportal/Providers/Providers.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      SizedBox(height: 10),
                      Consumer(
                        builder: (context, watch, child) {
                          var apodProviderData = watch(apodProvider);
                          return DCard(
                            image: CachedNetworkImage(
                              imageUrl: apodProviderData.image!,
                              fit: BoxFit.cover,
                            ),
                            text: apodProviderData.title,
                            onPressed: () =>
                                Navigator.pushNamed(context, kNASAPod_Page),
                          );
                        },
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
                      Consumer(
                        builder: (context, watch, child) {
                          var article = watch(articleProvider);
                          return article.when(
                            loading: () => Container(),
                            error: (e, s) => Text(''),
                            data: (data) => DCard(
                              image: CachedNetworkImage(
                                imageUrl: data.data[0].imageUrl,
                                fit: BoxFit.cover,
                              ),
                              text: 'News / Articles',
                              onPressed: () =>
                                  Navigator.pushNamed(context, kArticles_Page),
                            ),
                          );
                        },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

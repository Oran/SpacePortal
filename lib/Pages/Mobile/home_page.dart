import 'package:SpacePortal/network/models.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/components/home_page/card.dart';
import 'package:SpacePortal/constants.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<FSData>(context);
    var mars = Provider.of<MarsWeather>(context);
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
                child: PageView(
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
                height: (MediaQuery.of(context).size.height) * 0.50,
                width:  300.0,
                child: ListView.builder(
                  itemCount: mars.listDays.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        height: 150.0,
                        width: 150.0,
                        padding: EdgeInsets.all(10.0),
                        color: Colors.red[100],
                        child: Column(
                          children: [
                            //TODO: Make this look prettier
                            Text('Sol Day: ${mars.listDays[index].day}'),
                            Text('av: ${mars.listDays[index].av}'),
                            Text('min: ${mars.listDays[index].mn}'),
                            Text('max: ${mars.listDays[index].mx}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

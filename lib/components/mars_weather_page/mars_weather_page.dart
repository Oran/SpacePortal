import 'package:SpacePortal/components/mars_weather_page/mars_weather_card.dart';
import 'package:SpacePortal/components/mars_weather_page/mars_weather_minicard.dart';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarsWeatherPage extends StatefulWidget {
  @override
  _MarsWeatherPageState createState() => _MarsWeatherPageState();
}

class _MarsWeatherPageState extends State<MarsWeatherPage> {
  int index = 0;

  void updateMarsWeather(int dayIndex) {
    setState(() {
      index = dayIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mars = Provider.of<MarsWeather>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 25.0),
        color: Colors.white,
        height: (MediaQuery.of(context).size.height),
        width: (MediaQuery.of(context).size.width),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    '${mars.listDays[index].day}',
                    style: kMarsWeatherPageTS.copyWith(fontSize: 35.0),
                  ),
                  Text(
                    '${mars.listDays[index].av}\u2103',
                    style: kMarsWeatherPageTS.copyWith(
                      fontSize: 80.0,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${-70}\u2103',
                        style: kMarsWeatherPageTS.copyWith(
                          fontSize: 40.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 35.0),
                      Text(
                        '${-28}\u2103',
                        style: kMarsWeatherPageTS.copyWith(
                          fontSize: 40.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'summer',
                    style: kMarsWeatherPageTS.copyWith(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              color: Colors.grey,
              height: (MediaQuery.of(context).size.height) * 0.20,
              width: (MediaQuery.of(context).size.width),
              child: MarsWMiniCard(
                func: updateMarsWeather,
              ),
            ),
            Container(
              color: Colors.redAccent[100],
              height: (MediaQuery.of(context).size.height) * 0.41,
              width: (MediaQuery.of(context).size.width),
              // child: MarsWMiniCard(),
            ),
          ],
        ),
      ),
    );
  }
}

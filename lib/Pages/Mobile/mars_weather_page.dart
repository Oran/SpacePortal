import 'package:SpacePortal/components/mars_weather_page/compass.dart';
import 'package:SpacePortal/components/mars_weather_page/mars_weather_minicard.dart';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/models.dart';
import 'package:animated_rotation/animated_rotation.dart';
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
        color: Color(0xff0A0F2E),
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
                        '${mars.listDays[index].mx}\u2103',
                        style: kMarsWeatherPageTS.copyWith(
                          fontSize: 40.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 35.0),
                      Text(
                        '${mars.listDays[index].mn}\u2103',
                        style: kMarsWeatherPageTS.copyWith(
                          fontSize: 40.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${mars.listDays[index].season}',
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
              decoration: BoxDecoration(
                //color: Colors.red,
                shape: BoxShape.circle,
              ),
              height: (MediaQuery.of(context).size.height) * 0.34,
              width: (MediaQuery.of(context).size.width) * 0.591,
              child: CompassCircle(
                child: AnimatedRotation(
                  angle: mars.listDays[index].wd,
                  curve: Curves.linear,
                  duration: Duration(milliseconds: 800),
                  child: Icon(
                    //TODO: Choose another Icon
                    Icons.navigation_rounded,
                    color: Colors.white,
                    size: 80.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              color: Colors.transparent,
              height: (MediaQuery.of(context).size.height) * 0.22,
              width: (MediaQuery.of(context).size.width),
              child: MarsWMiniCard(func: updateMarsWeather),
            ),
          ],
        ),
      ),
    );
  }
}

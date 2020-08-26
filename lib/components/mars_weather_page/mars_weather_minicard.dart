import 'package:SpacePortal/components/mars_weather_page/mars_weather_page.dart';
import 'package:SpacePortal/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SpacePortal/network/models.dart';

class MarsWMiniCard extends StatelessWidget {
  /// Converts Temprature from Fahrenheit to Celcius
  int _convertTemp(double temp) {
    var result = (temp - 32) * 5 / 9;
    return result.round();
  }

  @override
  Widget build(BuildContext context) {
    var mars = Provider.of<MarsWeather>(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: mars.listDays.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(15),
            ),
            height: 100.0,
            width: 100.0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.ac_unit,
                    size: 40.0,
                  ),
                  Text(
                    '${_convertTemp(mars.listDays[index].av)}\u2103',
                    style: kWeatherCardTS.copyWith(
                      fontSize: 15.0,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_convertTemp(mars.listDays[index].mx)}\u2103',
                        style: kWeatherCardTS.copyWith(
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        '${_convertTemp(mars.listDays[index].mn)}\u2103',
                        style: kWeatherCardTS.copyWith(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    indent: 10.0,
                    endIndent: 10.0,
                    thickness: 2.0,
                  ),
                  Text(
                    '${mars.listDays[index].day}',
                    style: kWeatherCardTS.copyWith(
                      color: Colors.grey[600],
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

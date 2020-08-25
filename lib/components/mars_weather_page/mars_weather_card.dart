import 'package:SpacePortal/components/mars_weather_page/mars_weather_page.dart';
import 'package:SpacePortal/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SpacePortal/network/models.dart';

class MarsWeatherCard extends StatelessWidget {
  /// Converts Temprature from Fahrenheit to Celcius
  int _convertTemp(double temp) {
    var result = (temp - 32) * 5 / 9;
    return result.round();
  }

  @override
  Widget build(BuildContext context) {
    var mars = Provider.of<MarsWeather>(context);
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: mars.listDays.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MarsWeatherPage(index: index),
                ),
              );
            },
            child: Container(
              height: 80.0,
              width: (MediaQuery.of(context).size.width),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'SOL: ${mars.listDays[index].day}',
                      style: kWeatherCardTS.copyWith(
                        color: Colors.grey[600],
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Padding(
                      padding: EdgeInsets.only(bottom: 13.0),
                      child: SizedBox(
                        height: 50.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Text(
                              '${_convertTemp(mars.listDays[index].mx)}\u2103',
                              style: kWeatherCardTS,
                            ),
                            Text(
                              'Max',
                              style: kWeatherCardTS.copyWith(
                                fontSize: 10.0,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Padding(
                      padding: EdgeInsets.only(bottom: 13.0),
                      child: SizedBox(
                        height: 50.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Text(
                              '${_convertTemp(mars.listDays[index].mn)}\u2103',
                              style: kWeatherCardTS,
                            ),
                            Text(
                              'Min',
                              style: kWeatherCardTS.copyWith(
                                fontSize: 10.0,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Icon(
                      Icons.ac_unit,
                      size: 30.0,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

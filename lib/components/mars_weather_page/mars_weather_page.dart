import 'package:SpacePortal/network/models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarsWeatherPage extends StatelessWidget {
  MarsWeatherPage({this.index});
  final index;

  @override
  Widget build(BuildContext context) {
    var mars = Provider.of<MarsWeather>(context);
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${mars.listDays[index].day}'),
            Text('${mars.listDays[index].av}'),
            Text('${mars.listDays[index].mn}'),
            Text('${mars.listDays[index].mx}'),
          ],
        ),
      ),
    );
  }
}

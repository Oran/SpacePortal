import 'package:SpacePortal/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SpacePortal/network/models.dart';

class MarsWMiniCard extends StatelessWidget {
  MarsWMiniCard({this.func});
  final Function func;

  @override
  Widget build(BuildContext context) {
    var mars = Provider.of<MarsWeather>(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: mars.listDays.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => func(index),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
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
                      '${mars.listDays[index].av}\u2103',
                      style: kWeatherCardTS.copyWith(
                        fontSize: 15.0,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${mars.listDays[index].mx}\u2103',
                          style: kWeatherCardTS.copyWith(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          '${mars.listDays[index].mn}\u2103',
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
          ),
        );
      },
    );
  }
}

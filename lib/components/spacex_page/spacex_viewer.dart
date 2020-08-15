import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SXViewer extends StatelessWidget {
  SXViewer({this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    var spcx = Provider.of<List<dynamic>>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kAppBarColor,
      ),
      body: Container(
        padding: EdgeInsets.all(11.0),
        width: (MediaQuery.of(context).size.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150.0,
              width: 150.0,
              child: Image.network(
                spcx[index]['links']['mission_patch'] == null
                    ? kPlaceholderImage
                    : spcx[index]['links']['mission_patch'],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: Text(
                spcx[index]['mission_name'],
                style: kDetailsTS.copyWith(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              child: Text(
                SpaceXData().parseString(
                  spcx[index]['launch_date_utc'],
                ),
                style: kDetailsTS.copyWith(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Text(
                spcx[index]['details'] == null
                    ? 'Details not provided'
                    : spcx[index]['details'],
                style: kDetailsTS.copyWith(fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

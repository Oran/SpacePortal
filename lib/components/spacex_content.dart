import 'package:flutter/material.dart';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/network.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class SXContents extends StatelessWidget {
  SXContents({this.index});
  final int index;
  
  @override
  Widget build(BuildContext context) {
    var spcx = Provider.of<List<dynamic>>(context);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          spcx[index] == null
              ? Text(
                  'Data not Provided',
                  style: kTitleDateTS,
                )
              : Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      spcx[index]['links']['mission_patch'] == null
                          ? Text(
                              '\'Mission Patch not provided\'',
                              style: kTitleDateTS,
                            )
                          : Container(
                              height: 200.0,
                              width: 200.0,
                              child: CachedNetworkImage(
                                imageUrl: spcx[index]['links']['mission_patch'],
                              ),
                            ),
                      SizedBox(height: 15.0),
                      Text(
                        spcx[index]['mission_name'] == null
                            ? '\'Mission Name not Provided\''
                            : spcx[index]['mission_name'],
                        textAlign: TextAlign.center,
                        style: kTitleDateTS,
                      ),
                      Text(
                          SpaceXData().parseString(
                            spcx[index]['launch_date_utc'],
                          ),
                          style: kTitleDateTS),
                      spcx[index]['details'] == null
                          ? Text(
                              '\nDetails not Provided yet..',
                              style: kTitleDateTS,
                            )
                          : Text(
                              spcx[index]['details'],
                              style: kDetailsTS,
                            ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

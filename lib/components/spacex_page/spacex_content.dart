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
    return Container(
      child: Padding(
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
                    child: Row(
                      children: [
                        spcx[index]['links']['mission_patch'] == null
                            ? Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  height: 80.0,
                                  width: 80.0,
                                  child: CachedNetworkImage(
                                    imageUrl: kPlaceholderImage,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Container(
                                  height: 80.0,
                                  width: 80.0,
                                  child: CachedNetworkImage(
                                    imageUrl: spcx[index]['links']
                                        ['mission_patch'],
                                  ),
                                ),
                              ),
                        SizedBox(height: 15.0),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                spcx[index]['mission_name'] == null
                                    ? '\'Mission Name not Provided\''
                                    : spcx[index]['mission_name'],
                                textAlign: TextAlign.center,
                                style: kSpaceXTS,
                              ),
                              Text(
                                  SpaceXData().parseString(
                                    spcx[index]['launch_date_utc'],
                                  ),
                                  style: kSpaceXTS),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

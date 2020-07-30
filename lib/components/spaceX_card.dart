import 'package:SpacePortal/constants.dart';
import 'package:flutter/material.dart';
import '../network/network.dart';

class SpaceXCard extends StatelessWidget {
  const SpaceXCard({
    @required this.spaceXList,
    @required this.spaceX,
  });

  final List spaceXList;
  final SpaceXData spaceX;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: spaceXList == null ? 0 : spaceXList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            height: (MediaQuery.of(context).size.height * 0.70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: kAccentColor, width: 1.5),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  spaceXList[index] == null
                      ? Text(
                          'Data not Provided',
                          style: kTitleDateTS,
                        )
                      : Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              spaceXList[index]['links']['mission_patch'] ==
                                      null
                                  ? Text(
                                      '\'Mission Patch not provided\'',
                                      style: kTitleDateTS,
                                    )
                                  : Container(
                                      height: 200.0,
                                      width: 200.0,
                                      child: Image.network(
                                        spaceXList[index]['links']
                                            ['mission_patch'],
                                      ),
                                    ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                spaceXList[index]['mission_name'] == null
                                    ? '\'Mission Name not Provided\''
                                    : spaceXList[index]['mission_name'],
                                textAlign: TextAlign.center,
                                style: kTitleDateTS,
                              ),
                              Text(
                                  spaceX.parseString(
                                    spaceXList[index]['launch_date_utc'],
                                  ),
                                  style: kTitleDateTS),
                              spaceXList[index]['details'] == null
                                  ? Text(
                                      '\nDetails not Provided yet..',
                                      style: kTitleDateTS,
                                    )
                                  : Text(
                                      spaceXList[index]['details'],
                                      style: kDetailsTS,
                                    ),
                            ],
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

//1.links.mission_patch

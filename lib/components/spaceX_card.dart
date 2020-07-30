import 'package:SpacePortal/components/unicorn_container.dart';
import 'package:SpacePortal/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/network/network.dart';

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
              height: (MediaQuery.of(context).size.height) * 0.70,
              //TODO: Remove this check after bug is fixed check flutter repo.
              child: !kIsWeb
                  ? UnicornOutlineContainer(
                      radius: 20.0,
                      strokeWidth: 2.0,
                      gradient: kGradient,
                      child: Expanded(
                        child: SXContents(
                          spaceXList: spaceXList,
                          spaceX: spaceX,
                          index: index,
                        ),
                      ),
                    )
                  : Container(
                      height: (MediaQuery.of(context).size.height * 0.70),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: kAccentColor, width: 1.5),
                      ),
                      child: SXContents(
                        spaceXList: spaceXList,
                        spaceX: spaceX,
                        index: index,
                      ),
                    )),
        );
      },
    );
  }
}

class SXContents extends StatelessWidget {
  const SXContents({
    Key key,
    @required this.spaceXList,
    @required this.spaceX,
    @required this.index,
  }) : super(key: key);

  final List spaceXList;
  final SpaceXData spaceX;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      spaceXList[index]['links']['mission_patch'] == null
                          ? Text(
                              '\'Mission Patch not provided\'',
                              style: kTitleDateTS,
                            )
                          : Container(
                              height: 200.0,
                              width: 200.0,
                              child: Image.network(
                                spaceXList[index]['links']['mission_patch'],
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
    );
  }
}

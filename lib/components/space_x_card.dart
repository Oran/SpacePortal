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
      itemCount: spaceXList == null ? 0 : spaceXList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.grey[100], Colors.grey]),
              border: Border.all(width: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                spaceXList[index] == null
                    ? Text('null')
                    : Column(
                        children: [
                          Text(spaceXList[index]['mission_name']),
                          spaceXList[index]['details'] == null
                              ? Text('Null')
                              : Text(spaceXList[index]['details']),
                          Text(spaceX.parseString(
                              spaceXList[index]['launch_date_utc'])),
                        ],
                      ),
                RaisedButton(
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

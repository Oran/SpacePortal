import 'package:SpacePortal/components/spacex_content.dart';
import 'package:SpacePortal/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpaceXCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var spcx = Provider.of<List<dynamic>>(context);
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: spcx == null ? 0 : spcx.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            height: (MediaQuery.of(context).size.height) * 0.70,
            child: Container(
              height: (MediaQuery.of(context).size.height * 0.70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: kAccentColor, width: 1.5),
              ),
              child: SXContents(index: index),
            ),
          ),
        );
      },
    );
  }
}

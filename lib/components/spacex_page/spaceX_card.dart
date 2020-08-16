import 'package:SpacePortal/components/spacex_page/spacex_content.dart';
import 'package:SpacePortal/components/spacex_page/spacex_viewer.dart';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/network.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpaceXCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var spcx = Provider.of<List<dynamic>>(context);
    return Scaffold(
      body: RefreshIndicator(
        backgroundColor: kPrimaryBlack,
        color: kPrimaryWhite,
        onRefresh: () {
          print('page refreshed');
          return SpaceXData().getData();
        },
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: spcx == null ? 0 : spcx.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: (MediaQuery.of(context).size.height) * 0.20,
                decoration: BoxDecoration(
                  color: kAccentColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: GestureDetector(
                  child: SXContents(index: index),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SXViewer(index: index),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

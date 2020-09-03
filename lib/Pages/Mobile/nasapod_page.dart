import 'dart:ui';
import 'package:SpacePortal/components/nasapod_page/nasa_pod_viewer.dart';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/models.dart';
import 'package:SpacePortal/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NasaPod extends StatelessWidget {
  String parseString(String dateTime) {
    RegExp exp = RegExp(r"(\d\d\d\d-\d\d-\d\d)");
    String date = exp.firstMatch(dateTime).group(1);
    return date;
  }

  _openDialog(BuildContext context) {
    return showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime.parse('2000-01-01'),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: themeData.copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    ).then((value) => {
          parseString(value?.toString() ?? DateTime.now().toString()) ==
                  parseString(DateTime.now().toString())
              ? print('dates are the same')
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NasaPODViewer(
                      date: parseString(
                          value?.toString() ?? DateTime.now().toString()),
                    ),
                  ),
                ),
        });
  }

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<FSData>(context);
    var orientation = (MediaQuery.of(context).orientation);
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            elevation: 0,
            backgroundColor: kPrimaryWhite,
            pinned: true,
            floating: false,
            expandedHeight: 100.0,
            flexibleSpace: Stack(children: [
              Container(
                height: (MediaQuery.of(context).size.height),
                width: (MediaQuery.of(context).size.width),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Text(
                      '0',
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
              Container(
                child: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    height: (MediaQuery.of(context).size.height),
                    width: (MediaQuery.of(context).size.width),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: Text(
                          '0',
                          style: TextStyle(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  stretchModes: [
                    StretchMode.blurBackground,
                    StretchMode.zoomBackground,
                    // StretchMode.fadeTitle,
                  ],
                  centerTitle: true,
                  title: Text(
                    'Picture Of The Day',
                    style: kTitleDateTS.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ]),
            leading: GestureDetector(
              onTap: () {
                _openDialog(context);
              },
              child: Icon(Icons.tune_rounded),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: orientation == Orientation.landscape ? 800.0 : null,
                padding: EdgeInsets.all(10),
                // color: Colors.green,
                child: data.mediaType == 'video'
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            launch(
                              data.videoURL,
                              forceWebView: true,
                              enableJavaScript: true,
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                'Tap to play video',
                                style: kDetailsTS,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: CachedNetworkImage(
                                  imageUrl: data.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 10,
                              blurRadius: 10,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: CachedNetworkImage(
                            imageUrl: data.image,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Text(
                  data.title,
                  style: kTitleDateTS.copyWith(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Text(
                  data.date,
                  style: kTitleDateTS.copyWith(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  child: Text(
                    data.exp,
                    style: kDetailsTS.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ]),
          )
        ],
      ),
    );
  }
}

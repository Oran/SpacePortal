import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Pages/LaunchPage/LaunchViewer/Components/CountdownTimerText.dart';
import 'package:spaceportal/Pages/LaunchPage/LaunchViewer/Components/LaunchConfigText.dart';
import 'package:spaceportal/Pages/LaunchPage/LaunchViewer/Components/StatusText.dart';
import 'package:spaceportal/Pages/LaunchPage/ServiceProviderViewer/ServiceProviderViewer.dart';
import 'package:spaceportal/Providers/Providers.dart';
import 'package:spaceportal/Utils/Functions.dart';
import 'package:spaceportal/Utils/ExpandableWidget.dart';

class LaunchViewer extends ConsumerWidget {
  final int index;
  LaunchViewer({required this.index});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var data = watch(launchProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          //TODO: Change this later
          data.launchData[index].name,
          overflow: TextOverflow.fade,
          style: kTitleDateTS.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          // height: (MediaQuery.of(context).size.height),
          width: (MediaQuery.of(context).size.width),
          // color: Colors.pink[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                height: (MediaQuery.of(context).size.height) * 0.40,
                width: (MediaQuery.of(context).size.width) * 0.90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 10,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: data.launchData[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                // height: (MediaQuery.of(context).size.height),
                width: (MediaQuery.of(context).size.width) * 0.90,
                // color: Colors.grey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        data.launchData[index].name,
                        textAlign: TextAlign.center,
                        style: kTitleDateTS.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text(
                                        data.launchData[index].status.name,
                                        style: kDetailsTS.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: StatusText(
                                  data: data,
                                  index: index,
                                ),
                              ),
                              SizedBox(width: 10),
                              CountdownTimerText(
                                data: data,
                                index: index,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        LunchConfigText(
                          text1: 'Net Launch:',
                          text2:
                              '${parseDT(data.launchData[index].net)[0]} | ${parseDT(data.launchData[index].net)[1]}',
                          height: (MediaQuery.of(context).size.height) * 0.10,
                          width: (MediaQuery.of(context).size.width) * 0.875,
                        ),
                        SizedBox(height: 10),
                        Expandable(
                          isClickable: true,
                          primaryWidget: LunchConfigText(
                            text1: 'Mission:',
                            text2: data.launchData[index].mission.name,
                            height: (MediaQuery.of(context).size.height) * 0.10,
                            width: (MediaQuery.of(context).size.width) * 0.875,
                          ),
                          secondaryWidget: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            width: (MediaQuery.of(context).size.width) * 0.875,
                            // color: Colors.pink[200],
                            child: Text(
                              data.launchData[index].mission.description,
                              style: kDetailsTS,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        LunchConfigText(
                          text1: 'Launch Provider:',
                          text2: data.launchData[index].launchSP.name,
                          height: (MediaQuery.of(context).size.height) * 0.10,
                          width: (MediaQuery.of(context).size.width) * 0.875,
                          onTap: () => Navigator.push(
                            context,
                            routeTo(
                              ServiceProviderViewer(
                                url: data.launchData[index].launchSP.url,
                                id: data.launchData[index].launchSP.id,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
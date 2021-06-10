import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Pages/LaunchPage/Components/LaunchCard.dart';
import 'package:spaceportal/Providers/Providers.dart';
import 'package:spaceportal/Pages/LaunchPage/LaunchViewer/LaunchViewer.dart';
import 'package:spaceportal/Utils/Functions.dart';

class LaunchPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var data = watch(launchProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Text(
            'Launches',
            style: kTitleLargeTS.copyWith(
              fontSize: 45,
            ),
          ),
        ),
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height),
        width: (MediaQuery.of(context).size.width),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                physics: BouncingScrollPhysics(),
                cacheExtent: data.length.toDouble(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        routeTo(
                          LaunchViewer(index: index),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: LaunchCard(
                      image: CachedNetworkImage(
                        imageUrl: data.launchData[index].image,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          //TODO: this still needs testing.
                          return CircularProgressIndicator();
                        },
                      ),
                      text: data.launchData[index].name,
                      date: data.launchData[index].net,
                      statusColor: data.launchData[index].status.abbrev,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

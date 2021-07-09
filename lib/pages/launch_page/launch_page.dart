import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/pages/launch_page/components/launch_card.dart';
import 'package:spaceportal/providers/providers.dart';
import 'package:spaceportal/pages/launch_page/launch_viewer/launch_viewer.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:spaceportal/widgets/fadein_appbar.dart';
import 'package:spaceportal/constants.dart';

class LaunchPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var data = watch(launchProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Launches'),
        centerTitle: true,
        flexibleSpace: Consumer(
          builder: (context, watch, child) {
            var provider = watch(
              blurhashProvider(data
                  .launchData[
                      data.launchData[0].image == kPlaceholderImage ? 1 : 0]
                  .image),
            );
            return provider.when(
              data: (data) => FadeInAppBar(value: data),
              loading: () => Container(),
              error: (e, s) {
                print(e);
                print(s);
                return Container(
                  color: Colors.grey[100],
                );
              },
            );
          },
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
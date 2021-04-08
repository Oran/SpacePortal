import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/Pages/LaunchPage/Components/LaunchCard.dart';
import 'package:spaceportal/Providers/Providers.dart';

class LaunchPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var data = watch(launchProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Launches'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 15),
        physics: BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return LaunchCard(
            image: CachedNetworkImage(
              imageUrl: data.launchData[index].image,
              fit: BoxFit.cover,
            ),
            text: data.launchData[index].name,
            date: data.launchData[index].net,
          );
        },
      ),
    );
  }
}

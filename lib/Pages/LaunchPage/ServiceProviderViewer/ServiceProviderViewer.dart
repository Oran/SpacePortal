import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Network/LaunchNetwork.dart';

class ServiceProviderViewer extends StatefulWidget {
  final String url;
  final int id;
  ServiceProviderViewer({required this.url, required this.id});
  @override
  _ServiceProviderViewerState createState() => _ServiceProviderViewerState();
}

class _ServiceProviderViewerState extends State<ServiceProviderViewer> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ServiceProviderNetwork().getData(widget.url, widget.id),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                'Launch Provider',
                style: kDetailsTS.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
            body: Container(
              height: (MediaQuery.of(context).size.height),
              width: (MediaQuery.of(context).size.width),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                physics: BouncingScrollPhysics(),
                
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data['logo_url'],
                    ),
                  ),
                  Text(snapshot.data['name']),
                  Text(snapshot.data['type']),
                  Text(snapshot.data['founding_year']),
                  Text(snapshot.data['country_code']),
                  Text(snapshot.data['abbrev']),
                  Text(snapshot.data['administrator']),
                  Text(snapshot.data['description']),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Container(
                height: 400.0,
                width: 400.0,
                child: FlareActor(
                  'assets/animations/space.flr',
                  animation: 'Untitled',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

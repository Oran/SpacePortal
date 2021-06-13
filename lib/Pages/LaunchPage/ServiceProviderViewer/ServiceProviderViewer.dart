import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
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
            backgroundColor: Colors.amber[100],
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: Container(
              height: (MediaQuery.of(context).size.height),
              width: (MediaQuery.of(context).size.width),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Image.network(snapshot.data['logo_url']),
                  ),
                  Text(snapshot.data['name'].toString()),
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
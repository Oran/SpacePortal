import 'package:flutter/material.dart';
import './network.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NetworkData networkData = NetworkData();
  String result;
  String image;

  Future getImageData() async {
    networkData.getData();
    result = await networkData.getData();
    setState(() {
      image = result;
    });
  }

  @override
  void initState() {
    getImageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Root App'),
        ),
        body: Column(
          children: <Widget>[
            image == null ? CircularProgressIndicator() : Image.network(image),
            RaisedButton(
              child: Text('Tap Me'),
              onPressed: () {
                networkData.getData();
              },
            ),
          ],
        ),
      ),
    );
  }
}

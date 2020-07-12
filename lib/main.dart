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
  List result;
  List list;

  Future getImageData() async {
    result = await networkData.getData();
    setState(() {
      list = result;
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
          title: Text('Picture of the day'),
        ),
        body: Column(
          children: <Widget>[
            list[0] == null
                ? CircularProgressIndicator()
                : Image.network(list[0]),
            Text(
              list[1] == null ? 'text is null' : list[1],
              style: TextStyle(fontSize: 25),
            ),
            Text(
              list[3] == null ? 'text is null' : list[3],
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  list[2] == null ? 'text is null' : list[2],
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
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

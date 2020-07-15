import 'package:flutter/material.dart';
import 'package:flutterPlayground/network/network.dart';

class NasaPod extends StatefulWidget {
  @override
  _NasaPodState createState() => _NasaPodState();
}

class _NasaPodState extends State<NasaPod> {
  NasaData networkData = NasaData();
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
            list == null
                ? CircularProgressIndicator()
                : Image.network(list[0]),
            Text(
              list == null ? '' : list[1],
              style: TextStyle(fontSize: 25),
            ),
            Text(
              list == null ? '' : list[3],
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        list == null ? '' : list[2],
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
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

import 'package:flutter/material.dart';
import 'package:flutterPlayground/network/network.dart';

class Mars extends StatefulWidget {
  @override
  _MarsState createState() => _MarsState();
}

class _MarsState extends State<Mars> {
  NasaMarsData marsData = NasaMarsData();
  var list;
  int numOfPics;

  void getData() async {
    var data = await marsData.getMarsData();
    setState(() {
      list = data;
      numOfPics = data['photos'].length;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mars         Number of Pics - $numOfPics'),
      ),
      body: ListView.builder(
        itemCount: list == null
            ? 0
            : list['photos'].length == 856 ? 20 : list['photos'].length,
        itemBuilder: (context, index) {
          return Container(
            child: list['photos'][index]['img_src'] == null
                ? Text('image is null')
                : Image.network(
                    list['photos'][index]['img_src'],
                  ),
          );
        },
      ),
    );
  }
}

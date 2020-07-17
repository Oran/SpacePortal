import 'package:flutter/material.dart';
import 'package:SpacePortal/network/network.dart';

class Mars extends StatefulWidget {
  @override
  _MarsState createState() => _MarsState();
}

class _MarsState extends State<Mars> {
  NasaMarsData marsData = NasaMarsData();
  var list;
  int numOfPics;
  var camIn;
  var roverIn;
  var solIn;
  String selectedCam = 'navcam';
  String selectedRover = 'opportunity';
  String selectedSol = '100';

  void getData(camIn, roverIn, solIn) async {
    marsData.setURL(camIn, roverIn, solIn);
    var data = await marsData.getMarsData();
    setState(() {
      list = data;
      numOfPics = data['photos'].length;
    });
  }

  void setData() {
    setState(() {
      selectedCam = camIn;
      selectedRover = roverIn;
    });
  }

  DropdownButton<String> getDropdownButtonCamera() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String camera in cam) {
      var newItem = DropdownMenuItem(
        child: Text(camera),
        value: camera,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCam,
      items: dropdownItems,
      onChanged: (value) {
        print(value);
        setState(() {
          selectedCam = value;
        });
      },
    );
  }

  DropdownButton<String> getDropdownButtonRover() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String rovers in rover) {
      var newItem = DropdownMenuItem(
        child: Text(rovers),
        value: rovers,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedRover,
      items: dropdownItems,
      onChanged: (value) {
        print(value);
        setState(() {
          selectedRover = value;
        });
      },
    );
  }

  @override
  void initState() {
    getData(selectedCam, selectedRover, selectedSol);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mars\nNumber of Pics - $numOfPics'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                child: Icon(Icons.cached),
                onTap: () {
                  //getData();
                  getData(selectedCam, selectedRover, selectedSol);
                }),
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              getDropdownButtonCamera(),
              getDropdownButtonRover(),
              TextField(
                onChanged: (value) {
                  print(value);
                  setState(() {
                    selectedSol = value;
                  });
                },
              ),
            ],
          ),
        ),
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

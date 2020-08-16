import 'package:SpacePortal/components/mars_page/mars_photos.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/network.dart';
import 'package:http/http.dart';

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
  String selectedCam = 'mast'; //Defaults
  String selectedRover = 'curiosity';
  String selectedSol = '59';

  Future getData(camIn, roverIn, solIn) async {
    marsData.setURL(camIn, roverIn, solIn);
    var data = await marsData.getMarsData();
    setState(() {
      list = data;
      numOfPics = data['photos'].length;
    });
  }

  DropdownButtonFormField<String> _getDropdownButtonCamera() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String camera in cam) {
      var newItem = DropdownMenuItem(
        child: Text(camera),
        value: camera,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButtonFormField<String>(
      style: kDetailsTS,
      decoration: InputDecoration(
        labelText: 'Camera',
        labelStyle: kDetailsTS.copyWith(
          color: kDropDownButtonColor,
        ),
        border: InputBorder.none,
      ),
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

  DropdownButtonFormField<String> _getDropdownButtonRover() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String rovers in rover) {
      var newItem = DropdownMenuItem(
        child: Text(rovers),
        value: rovers,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButtonFormField<String>(
      style: kDetailsTS,
      decoration: InputDecoration(
        labelText: 'Rover Name',
        labelStyle: kDetailsTS.copyWith(
          color: kDropDownButtonColor,
        ),
        border: InputBorder.none,
      ),
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

  _createDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Container(
              height: 300.0,
              width: 300.0,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Center(
                          child: _getDropdownButtonCamera(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Center(
                          child: _getDropdownButtonRover(),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        cursorColor: kAccentColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: 'Days on Mars',
                          labelStyle: kDetailsTS.copyWith(
                            color: kAccentColor,
                          ),
                          contentPadding: EdgeInsets.all(11),
                          border: InputBorder.none,
                        ),
                        style: kDetailsTS,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            selectedSol = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        getData(selectedCam, selectedRover, selectedSol);
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: kAccentColor),
                            color: kAccentColor),
                        child: Icon(
                          Icons.cached,
                          color: kIconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.only(top: 40.0, left: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          child: Icon(
                            Icons.subject,
                            size: 30.0,
                          ),
                          onTap: () {
                            _createDialog(context);
                          },
                        ),
                      ),
                      Text(
                        'Mars Rover Images',
                        style: kTitleLargeTS.copyWith(
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Number of pictures: $numOfPics',
                          style: kMarsStatsStyle),
                      Text('Rover: $selectedRover', style: kMarsStatsStyle),
                      Text('Camera: $selectedCam', style: kMarsStatsStyle),
                      Text('Sol Days on mars: $selectedSol',
                          style: kMarsStatsStyle),
                    ],
                  ),
                ],
              ),
            ),
            MarsPhotos(numOfPics: numOfPics, list: list),
          ],
        ),
      ),
    );
  }
}

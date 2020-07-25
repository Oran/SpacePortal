import 'package:SpacePortal/constants.dart';
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
  String selectedCam = 'navcam'; //Defaults
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

  DropdownButtonFormField<String> getDropdownButtonCamera() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String camera in cam) {
      var newItem = DropdownMenuItem(
        child: Text(camera),
        value: camera,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButtonFormField<String>(
      dropdownColor: Colors.grey[300],
      decoration: InputDecoration(
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

  DropdownButtonFormField<String> getDropdownButtonRover() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String rovers in rover) {
      var newItem = DropdownMenuItem(
        child: Text(rovers),
        value: rovers,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButtonFormField<String>(
      dropdownColor: Colors.grey[300],
      decoration: InputDecoration(
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

  @override
  void initState() {
    getData(selectedCam, selectedRover, selectedSol);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDarkPurple,
      appBar: AppBar(
        title: Text('Mars Rover Images\nNumber of Images - $numOfPics'),
        elevation: 0,
        backgroundColor: kPrimaryDarkPurple,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                child: Icon(Icons.cached),
                onTap: () {
                  getData(selectedCam, selectedRover, selectedSol);
                }),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: kPrimaryDarkPurple,
          child: Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                      leading: Icon(
                        Icons.account_balance,
                        color: kPrimaryWhite,
                      ),
                      title: Text(
                        'NASA Picture of the day',
                        style: kDetailsTS,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, knasapod_ID);
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                      leading: Icon(
                        Icons.account_balance,
                        color: kPrimaryWhite,
                      ),
                      title: Text(
                        'SpaceX Launch Timetable',
                        style: kDetailsTS,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, kspaceX_ID);
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                      leading: Icon(
                        Icons.account_balance,
                        color: kPrimaryWhite,
                      ),
                      title: Text(
                        'Mars stuff',
                        style: kDetailsTS,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, kmars_ID);
                      },
                    ),
                  ],
                ),
                SizedBox(height: (MediaQuery.of(context).size.height * 0.10)),
                Column(
                  children: [
                    Text('Camera', style: kDetailsTS),
                    Container(
                      width: 150.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Center(
                          child: getDropdownButtonCamera(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('Rover Name', style: kDetailsTS),
                    Container(
                      width: 150.0,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Center(child: getDropdownButtonRover()),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(' Solar days on Mars', style: kDetailsTS),
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey[900], width: 2.0),
                          borderRadius: BorderRadius.circular(10)),
                      width: 150.0,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'SOL Days',
                          hintStyle: TextStyle(color: Colors.grey),
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
                    RaisedButton(
                      child: Icon(Icons.cached),
                      color: Colors.grey[400],
                      onPressed: () {
                        getData(selectedCam, selectedRover, selectedSol);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: numOfPics == 0
          ? Center(
              child: Text(
                'No Images Provided',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: list == null
                  ? 0
                  : list['photos'].length == 856 ? 20 : list['photos'].length,
              itemBuilder: (context, index) {
                return Container(
                  child: list == null
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Image is null',
                              style: kTitleDateTS.copyWith(color: Colors.black),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              list['photos'][index]['img_src'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                );
              },
            ),
    );
  }
}

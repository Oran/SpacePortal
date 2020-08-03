import 'package:SpacePortal/components/image_viewer.dart';
import 'package:SpacePortal/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
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

  //? Not sure why I have this block
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

  Widget circle(BuildContext context, String text) {
    return Center(
      child: Container(
        height: 30.0,
        width: 30.0,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(kAccentSkyBlue),
        ),
      ),
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
      // backgroundColor: kPrimaryDarkPurple,
      appBar: AppBar(
        title: Text('Mars Rover Images\nNumber of Images - $numOfPics'),
        elevation: 0,
        //backgroundColor: kAppBarColor,
        flexibleSpace: Container(decoration: kAppbarBoxDecoration),
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
          color: kDrawerColor,
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
                        color: kIconColor,
                      ),
                      title: Text(
                        'NASA Picture of the day',
                        style: kDetailsTS,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, kNASAPod_Page);
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                      leading: Icon(
                        Icons.account_balance,
                        color: kIconColor,
                      ),
                      title: Text(
                        'SpaceX Launch Timetable',
                        style: kDetailsTS,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, kSpaceX_Page);
                      },
                    ),
                  ],
                ),
                SizedBox(height: (MediaQuery.of(context).size.height * 0.10)),
                Column(
                  children: [
                    Container(
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kAccentColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Center(
                          child: getDropdownButtonCamera(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kAccentColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Center(child: getDropdownButtonRover()),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kAccentColor),
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
                          color: kPrimaryBlack,
                        ),
                      ),
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
                style: kTitleDateTS,
              ),
            )
          : GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: list == null
                  ? 0
                  : list['photos'].length == 856 ? 20 : list['photos'].length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.of(context).orientation ==
                          Orientation.portrait)
                      ? 2
                      : 5),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey,
                      //     spreadRadius: -20,
                      //     blurRadius: 25,
                      //     offset: Offset(0, 0),
                      //   ),
                      // ],
                      ),
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
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: GestureDetector(
                              child: Hero(
                                tag: 'tag' + index.toString(),
                                child: kIsWeb
                                    ? Image.network(
                                        list['photos'][index]['img_src'])
                                    : CachedNetworkImage(
                                        imageUrl: list['photos'][index]
                                            ['img_src'],
                                        fit: BoxFit.fill,
                                        placeholder: circle,
                                      ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageViewer(
                                        index: index,
                                        list: list['photos'][index]['img_src']),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                );
              },
            ),
    );
  }
}

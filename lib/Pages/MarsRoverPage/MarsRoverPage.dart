import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/Network/MarsRoverNetwork.dart';
import 'package:spaceportal/Pages/MarsRoverPage/Components/MarsRoverImages.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/Constants.dart';
import 'Components/SlidingUpPanel.dart';

class MarsRoverPage extends StatefulWidget {
  @override
  _MarsRoverPageState createState() => _MarsRoverPageState();
}

class _MarsRoverPageState extends State<MarsRoverPage> {
  MarsRoverImageData marsData = MarsRoverImageData();
  var list;
  int? numOfPics;
  var camIn;
  var roverIn;
  var solIn;
  String? selectedCam = 'EDL_RUCAM'; //Defaults
  String? selectedRover = 'perseverance';
  String selectedSol = '1';

  var container = ProviderContainer();
  PanelController panelController = PanelController();
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Future getData(camIn, roverIn, solIn) async {
    //print('$selectedCam, $selectedRover, $selectedSol');
    marsData.setURL(camIn, roverIn, solIn);
    var data = await marsData.getMarsData();
    // print(data);
    setState(() {
      list = data;
      numOfPics = data['photos'].length;
    });
  }

  var roverList = rover.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  var newCamera = newCam.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  var oldCamera = oldCam.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();

  @override
  void initState() {
    super.initState();
    getData(selectedCam, selectedRover, selectedSol);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        maxHeight: 400.0,
        minHeight: 30.0,
        backdropEnabled: true,
        defaultPanelState: PanelState.CLOSED,
        parallaxEnabled: true,
        controller: panelController,
        collapsed: GestureDetector(
          onTap: () {
            panelController.open();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(child: Icon(Icons.keyboard_arrow_up)),
          ),
        ),
        backdropTapClosesPanel: true,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        panel: GestureDetector(
          onTap: () {
            focusNode.unfocus();
          },
          child: Container(
            height: (MediaQuery.of(context).size.height),
            width: (MediaQuery.of(context).size.width),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: 250.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Center(
                        child: DropdownButtonFormField<String>(
                          style: kDetailsTS,
                          decoration: InputDecoration(
                            labelText: 'Camera',
                            labelStyle: kDetailsTS.copyWith(
                              color: kDropDownButtonColor,
                            ),
                            border: InputBorder.none,
                          ),
                          value: selectedCam,
                          items: selectedRover == 'perseverance'
                              ? newCamera
                              : oldCamera,
                          onChanged: (value) {
                            //print(value);
                            setState(() {
                              selectedCam = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 250.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Center(
                        child: DropdownButtonFormField<String>(
                          style: kDetailsTS,
                          decoration: InputDecoration(
                            labelText: 'Rover Name',
                            labelStyle: kDetailsTS.copyWith(
                              color: kDropDownButtonColor,
                            ),
                            border: InputBorder.none,
                          ),
                          value: selectedRover,
                          items: roverList,
                          onChanged: (value) {
                            //print(value);
                            setState(() {
                              selectedRover = value;
                              selectedRover == 'perseverance'
                                  ? selectedCam = 'EDL_RUCAM'
                                  : selectedCam = 'mast';
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 60.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      cursorColor: kAccentColor,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      controller: editingController,
                      decoration: InputDecoration(
                        labelText: 'Days on Mars (SOL days)',
                        labelStyle: kDetailsTS.copyWith(
                          color: kAccentColor,
                        ),
                        contentPadding: EdgeInsets.all(11),
                        border: InputBorder.none,
                      ),
                      style: kDetailsTS,
                      onChanged: (value) {
                        selectedSol = value;
                      },
                      focusNode: focusNode,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      getData(selectedCam, selectedRover, selectedSol);
                      focusNode.unfocus();
                      panelController.close();
                    },
                    child: Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: kAccentColor),
                          color: kAccentColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cached,
                            color: kIconColor,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Reload',
                            style: kDetailsTS.copyWith(color: kPrimaryWhite),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          cacheExtent: 500.0,
          slivers: [
            SliverAppBar(
              backgroundColor: kPrimaryWhite,
              pinned: true,
              floating: true,
              expandedHeight: 120.0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                title: Text('Mars Rover Images'),
                background: Container(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Number of pictures: $numOfPics',
                              style: kMarsStatsStyle),
                          Text('Rover: $selectedRover', style: kMarsStatsStyle),
                          Text('Camera: $selectedCam', style: kMarsStatsStyle),
                          Text('Sol Days on mars: $selectedSol',
                              style: kMarsStatsStyle),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              leading: GestureDetector(
                child: Icon(
                  Icons.subject,
                  size: 30.0,
                ),
                onTap: () {
                  panelController.open();
                },
              ),
            ),
            numOfPics == 0
                ? SliverList(
                    delegate: SliverChildListDelegate([
                      Center(
                        child: Text(
                          'No Images Provided',
                          style: kTitleDateTS,
                        ),
                      ),
                    ]),
                  )
                : MarsRoverImages(list: list),
          ],
        ),
      ),
    );
  }
}

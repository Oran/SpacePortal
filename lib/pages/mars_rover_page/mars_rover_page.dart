import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:spaceportal/constants.dart';
import 'package:spaceportal/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/network/mars_rover_network.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:spaceportal/widgets/fadein_appbar.dart';
import 'package:spaceportal/widgets/slidingup_panel.dart';
import 'components/mars_bold_text.dart';
import 'components/mars_rover_images.dart';
import 'components/mars_rover_latest_images.dart';

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
  bool isLatestPhotos = true;

  var container = ProviderContainer();
  PanelController panelController = PanelController();
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Widget panelIndicator() {
    if (panelController.isAttached || panelController.isPanelOpen) {
      return Icon(Icons.horizontal_rule_rounded);
    } else {
      return SizedBox(height: 10);
    }
  }

  Future getData(camIn, roverIn, solIn) async {
    //print('$selectedCam, $selectedRover, $selectedSol');
    marsData.setURL(camIn, roverIn, solIn, isLatestPhotos);

    if (isLatestPhotos) {
      var latestPhotos = await marsData.getMarsData();
      setState(() {
        list = latestPhotos;
        numOfPics = latestPhotos['latest_photos'].length;
      });
    } else {
      var data = await marsData.getMarsData();

      // print(data);
      setState(() {
        list = data;
        numOfPics = data['photos'].length;
      });
    }
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

  String appBarUrl(apiData) {
    if (isLatestPhotos) {
      return apiData == null
          ? kPlaceholderImage
          : apiData['latest_photos'] == null ||
                  apiData['latest_photos'].length == 0
              ? kPlaceholderImage
              : apiData['latest_photos'][0]['img_src'];
    } else {
      return apiData == null
          ? kPlaceholderImage
          : apiData['photos'] == null || apiData['photos'].length == 0
              ? kPlaceholderImage
              : apiData['photos'][0]['img_src'];
    }
  }

  @override
  void initState() {
    super.initState();
    getData(selectedCam, selectedRover, selectedSol);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        var whiteBalance = watch(whiteBalanceProvider(appBarUrl(list)));
        return whiteBalance.when(
            data: (wb) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Mars Rover Images',
                    style: TextStyle(
                      color: changeColorAppBar(wb),
                    ),
                  ),
                  iconTheme: IconThemeData(
                    color: changeColorAppBar(wb),
                  ),
                  flexibleSpace: Consumer(
                    builder: (context, watch, child) {
                      var provider = watch(blurhashProvider(appBarUrl(list)));
                      return provider.when(
                        data: (data) => FadeInAppBar(value: data),
                        loading: () => Container(),
                        error: (e, s) {
                          print(e);
                          print(s);
                          return Container(
                            color: Colors.grey[100],
                          );
                        },
                      );
                    },
                  ),
                  actions: [
                    InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.more_vert_rounded,
                          size: 30.0,
                        ),
                      ),
                      onTap: () {
                        panelController.open();
                      },
                    ),
                  ],
                ),
                body: SlidingUpPanel(
                  maxHeight: 500.0,
                  minHeight: 40.0,
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
                            Icon(Icons.keyboard_arrow_down),
                            Container(
                              // color: Colors.pink[100],
                              // height: (MediaQuery.of(context).size.height) * 0.30,
                              width:
                                  (MediaQuery.of(context).size.height) * 0.90,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MarsBoldText(
                                    text1: 'Number of Pictures: ',
                                    text2: '$numOfPics',
                                  ),
                                  MarsBoldText(
                                    text1: 'Rover Name: ',
                                    text2: '$selectedRover',
                                  ),
                                  isLatestPhotos
                                      ? Container()
                                      : MarsBoldText(
                                          text1: 'Camera: ',
                                          text2: '$selectedCam',
                                        ),
                                  isLatestPhotos
                                      ? Container()
                                      : MarsBoldText(
                                          text1: 'Sol Day: ',
                                          text2: '$selectedSol',
                                        ),
                                ],
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isLatestPhotos = false;
                                    });
                                    getData(selectedCam, selectedRover,
                                        selectedSol);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.search_rounded,
                                          color: kIconColor,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Search',
                                          style: kDetailsTS.copyWith(
                                              color: kPrimaryWhite),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isLatestPhotos = true;
                                    });
                                    getData(selectedCam, selectedRover,
                                        selectedSol);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cached_rounded,
                                          color: kIconColor,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Show Latest',
                                          style: kDetailsTS.copyWith(
                                              color: kPrimaryWhite),
                                        )
                                      ],
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
                      : isLatestPhotos
                          ? MarsRoverLatestImages(list: list)
                          : MarsRoverImages(list: list),
                ),
              );
            },
            loading: () => Scaffold(body: flareLoadingAnimation()),
            error: (e, s) => Text('error'));
      },
    );
  }
}

import 'dart:ui';
import 'package:SpacePortal/components/nasapod_page/nasa_pod_viewer.dart';
import 'package:SpacePortal/components/nasapod_page/pod_contents.dart';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/network.dart';
import 'package:SpacePortal/providers.dart';
import 'package:SpacePortal/theme/theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'package:provider/provider.dart';
enum wb { white, black }

// ignore: must_be_immutable
class NasaPod extends ConsumerWidget {
  wb bulll;

  String parseString(String dateTime) {
    RegExp exp = RegExp(r"(\d\d\d\d-\d\d-\d\d)");
    String date = exp.firstMatch(dateTime).group(1);
    return date;
  }

  _openDialog(BuildContext context) {
    return showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime.parse('2000-01-01'),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: themeData.copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    ).then((value) => {
          parseString(value?.toString() ?? DateTime.now().toString()) ==
                  parseString(DateTime.now().toString())
              ? print('dates are the same')
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NasaPODViewer(
                      date: parseString(
                          value?.toString() ?? DateTime.now().toString()),
                    ),
                  ),
                ),
        });
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //var data = Provider.of<FSData>(context);
    var apodProviderData = watch(apodProvider);
    return FutureBuilder(
      future: NasaPODData().checkImgColor(apodProviderData.data.value.image),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  stretch: false,
                  elevation: 0,
                  backgroundColor: kPrimaryWhite,
                  pinned: true,
                  floating: false,
                  expandedHeight: 50.0,
                  flexibleSpace: Stack(
                    children: [
                      Container(
                        height: (MediaQuery.of(context).size.height),
                        width: (MediaQuery.of(context).size.width),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(apodProviderData.data.value.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Text(
                              '0',
                              style: TextStyle(color: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: Container(
                            height: (MediaQuery.of(context).size.height),
                            width: (MediaQuery.of(context).size.width),
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Text(
                                  '0',
                                  style: TextStyle(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                          centerTitle: true,
                          title: AnimatedDefaultTextStyle(
                            style: kTitleDateTS.copyWith(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: snapshot.data < 127
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            duration: Duration(milliseconds: 250),
                            child: Text(
                              'Picture Of The Day',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  leading: GestureDetector(
                    onTap: () {
                      _openDialog(context);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      child: Icon(
                        Icons.tune_rounded,
                        color:
                            snapshot.data < 127 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                PodContents(),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Container(
                height: 400.0,
                width: 400.0,
                child: FlareActor(
                  'assets/animations/space.flr',
                  animation: 'Untitled',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

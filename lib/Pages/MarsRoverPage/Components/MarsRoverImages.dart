import 'package:SpacePortal/Pages/MarsRoverPage/Components/ImageViewer.dart';
import 'package:SpacePortal/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MarsRoverImages extends StatelessWidget {
  const MarsRoverImages({
    required this.list,
  });

  final list;

  Widget circle(BuildContext context, String text) {
    return Center(
      child: Container(
        height: 30.0,
        width: 30.0,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryBlack),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: -20,
                        blurRadius: 25,
                        offset: Offset(0, 0),
                      ),
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: -15,
                        blurRadius: 15,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: list == null
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Image is null',
                              style:
                                  kTitleDateTS.copyWith(color: Colors.black),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: GestureDetector(
                              child: CachedNetworkImage(
                                imageUrl: list['photos'][index]['img_src'],
                                fit: BoxFit.fill,
                                placeholder: circle,

                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageViewer(
                                      index: index,
                                      list: list['photos'][index]['img_src'],
                                      earthDate: list['photos'][index]
                                          ['earth_date'],
                                      cameraName: list['photos'][index]
                                          ['camera']['full_name'],
                                      roverName: list['photos'][index]
                                          ['rover']['name'],
                                      status: list['photos'][index]['rover']
                                          ['status'],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                );
              },
              childCount: list == null
                  ? 0
                  : list['photos'].length == 856 ? 20 : list['photos'].length,
            ),
          );
  }
}
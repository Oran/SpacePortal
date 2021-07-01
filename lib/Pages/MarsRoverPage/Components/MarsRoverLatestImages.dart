import 'package:spaceportal/Pages/MarsRoverPage/Components/ImageViewer.dart';
import 'package:spaceportal/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/Utils/Functions.dart';

class MarsRoverLatestImages extends StatelessWidget {
  const MarsRoverLatestImages({
    required this.list,
  });

  final list;

  Widget circle(BuildContext context, String? text) {
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
    return Scrollbar(
      interactive: true,
      child: GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        children: List.generate(
          list == null
              ? 0
              : list['latest_photos'] == null
                  ? 0
                  : list['latest_photos'].length,
          (index) => Container(
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
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(kPrimaryBlack),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: GestureDetector(
                        child: CachedNetworkImage(
                          imageUrl: list['latest_photos'] == null
                              ? kPlaceholderImage
                              : list['latest_photos'][index]['img_src'],
                          fit: BoxFit.fill,
                          placeholder: circle,
                          memCacheHeight: 200,
                          memCacheWidth: 200,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            routeTo(
                              ImageViewer(
                                index: index,
                                list: list['latest_photos'][index]['img_src'],
                                earthDate: list['latest_photos'][index]
                                    ['earth_date'],
                                cameraName: list['latest_photos'][index]
                                    ['camera']['full_name'],
                                roverName: list['latest_photos'][index]['rover']
                                    ['name'],
                                status: list['latest_photos'][index]['rover']
                                    ['status'],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

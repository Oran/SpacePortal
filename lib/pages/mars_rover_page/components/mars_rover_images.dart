import 'package:spaceportal/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:spaceportal/pages/mars_rover_page/image_viewer/image_viewer.dart';
import 'package:theme_provider/theme_provider.dart';

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
    var theme = ThemeProvider.themeOf(context);
    return Scrollbar(
      interactive: true,
      child: GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        children: List.generate(
          list == null
              ? 0
              : list['photos'] == null
                  ? 0
                  : list['photos'].length,
          (index) => Container(
            decoration: BoxDecoration(
              boxShadow: showBoxShadow(theme.id, isRoverImages: true),
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
                          imageUrl: list['photos'] == null
                              ? kPlaceholderImage
                              : list['photos'][index]['img_src'],
                          fit: BoxFit.fill,
                          placeholder: circle,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            routeTo(
                              ImageViewer(
                                index: index,
                                list: list['photos'][index]['img_src'],
                                earthDate: list['photos'][index]['earth_date'],
                                cameraName: list['photos'][index]['camera']
                                    ['full_name'],
                                roverName: list['photos'][index]['rover']
                                    ['name'],
                                status: list['photos'][index]['rover']
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

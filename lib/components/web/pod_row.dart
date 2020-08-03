import 'package:SpacePortal/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

class PODRow extends StatelessWidget {
  const PODRow({
    Key key,
    @required this.orientation,
    @required this.list,
    @required this.box,
  }) : super(key: key);

  final Orientation orientation;
  final List list;
  final Box box;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            height: orientation == Orientation.landscape ? 800.0 : null,
            // color: Colors.green,
            child: list[0] == 'video'
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        launch(Hive.box('cacge').get('image'));
                      },
                      child: Text(
                        '${Hive.box('cache').get('image')}',
                        textAlign: TextAlign.center,
                        style: kDetailsTS.copyWith(color: Colors.red),
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: kIsWeb
                        ? Image(
                            image: NetworkImage(
                              box.get('image'),
                            ),
                            fit: BoxFit.fill,
                          )
                        : CachedNetworkImage(
                            imageUrl: box.get('image'),
                            fit: BoxFit.fill,
                          ),
                  ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  child: Text(
                    box.get('title'),
                    style: kTitleDateTS.copyWith(fontSize: 40.0),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  child: Text(
                    box.get('date'),
                    style: kTitleDateTS.copyWith(fontSize: 25.0),
                  ),
                ),
                Container(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    child: Text(
                      box.get('exp'),
                      style: kDetailsTS.copyWith(
                          letterSpacing: 1.0, fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

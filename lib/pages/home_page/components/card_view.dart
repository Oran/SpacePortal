import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/pages/home_page/components/card.dart';
import 'package:spaceportal/routes.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:spaceportal/providers/providers.dart';
import 'package:spaceportal/constants.dart';

class CardView extends StatefulWidget {
  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  ScrollController _controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        offset = _controller.offset * -0.010;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      controller: _controller,
      padding: EdgeInsets.zero,
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(height: 10),
        Consumer(
          builder: (context, ref, child) {
            var apodProviderData = ref.watch(apodProvider);
            return DCard(
              image: CachedNetworkImage(
                imageUrl: apodProviderData.mediaType == 'video'
                    ? apodProviderData.videoThumb!
                    : apodProviderData.image!,
                fit: BoxFit.cover,
                memCacheHeight: 800,
                memCacheWidth: 800,
                // alignment: Alignment(
                //   0,
                //   offsetValue(offset) *
                //       getImgHeightDiff(
                //         apodProviderData.mediaType == 'video'
                //             ? apodProviderData.videoThumb!
                //             : apodProviderData.image!,
                //       ),
                // ),
              ),
              text: apodProviderData.title,
              onPressed: () => Navigator.push(
                context,
                routeTo(
                  rApodPage,
                ),
              ),
            );
          },
        ),
        DCard(
          image: Image.asset(
            'assets/images/mars_rover.jpg',
            fit: BoxFit.cover,
            cacheHeight: 800,
            cacheWidth: 1000,
            // alignment: Alignment(0, offsetValue(offset) * 0.5),
          ),
          text: 'Mars Rover Images',
          onPressed: () => Navigator.push(
            context,
            routeTo(rMarsPage),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            var data = ref.watch(launchProvider);
            return DCard(
              image: CachedNetworkImage(
                imageUrl: data
                    .launchData[
                        data.launchData[0].image == kPlaceholderImage ? 1 : 0]
                    .image,
                fit: BoxFit.cover,
                memCacheHeight: 800,
                memCacheWidth: 1000,
                // alignment: Alignment(
                //   0,
                //   offsetValue(offset) *
                //       getImgHeightDiff(data.launchData[0].image),
                // ),
              ),
              text: 'Launch Schedule',
              onPressed: () => Navigator.push(
                context,
                routeTo(rLaunchPage),
              ),
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            var article = ref.watch(articleProvider);
            return DCard(
              image: CachedNetworkImage(
                imageUrl: article.data[0].imageUrl,
                fit: BoxFit.cover,
                memCacheHeight: 800,
                memCacheWidth: 1000,
                // alignment: Alignment(
                //   0,
                //   offsetValue(offset) *
                //       getImgHeightDiff(data.data[0].imageUrl),
                // ),
              ),
              text: 'News / Articles',
              onPressed: () => Navigator.push(
                context,
                routeTo(rArticlesPage),
              ),
            );
          },
        ),
        // DCard(
        //   image: Container(color: Colors.black),
        //   text: 'TEST PAGE',
        //   onPressed: () => Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => TestPage(),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

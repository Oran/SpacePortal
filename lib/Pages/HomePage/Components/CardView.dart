import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Functions.dart';
import 'package:spaceportal/Pages/HomePage/Components/Card.dart';
import 'package:spaceportal/Pages/TestPage.dart';
import 'package:spaceportal/Providers/Providers.dart';

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
          builder: (context, watch, child) {
            var apodProviderData = watch(apodProvider);
            return DCard(
              image: CachedNetworkImage(
                imageUrl: apodProviderData.mediaType == 'video'
                    ? apodProviderData.videoThumb!
                    : apodProviderData.image!,
                fit: BoxFit.cover,
                alignment: Alignment(
                  0,
                  offsetValue(offset) *
                      getImgHeightDiff(
                        apodProviderData.mediaType == 'video'
                            ? apodProviderData.videoThumb!
                            : apodProviderData.image!,
                      ),
                ),
              ),
              text: apodProviderData.title,
              onPressed: () => Navigator.pushNamed(context, kNASAPod_Page),
            );
          },
        ),
        DCard(
          image: Image.asset(
            'assets/images/mars_rover.jpg',
            fit: BoxFit.cover,
            alignment: Alignment(0, offsetValue(offset) * 0.5),
          ),
          text: 'Mars Rover Images',
          onPressed: () => Navigator.pushNamed(context, kMars_Page),
        ),
        Consumer(
          builder: (context, watch, child) {
            var article = watch(articleProvider);
            return article.when(
              loading: () => Container(),
              error: (e, s) => Text(''),
              data: (data) => DCard(
                image: CachedNetworkImage(
                  imageUrl: data.data[0].imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment(
                    0,
                    offsetValue(offset) *
                        getImgHeightDiff(data.data[0].imageUrl),
                  ),
                ),
                text: 'News / Articles',
                onPressed: () => Navigator.pushNamed(context, kArticles_Page),
              ),
            );
          },
        ),
        DCard(
          image: Container(color: Colors.black),
          text: 'TEST PAGE',
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TestPage(),
            ),
          ),
        ),
      ],
    );
  }
}

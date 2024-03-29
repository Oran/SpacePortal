import 'package:spaceportal/providers/providers.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:spaceportal/widgets/fadein_appbar.dart';
import 'package:spaceportal/pages/apod_page/components/apod_container.dart';
import 'package:spaceportal/pages/apod_page/components/apod_viewer.dart';
import 'package:spaceportal/pages/apod_page/components/download_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class APODPage extends ConsumerWidget {
  _openDialog(BuildContext context) {
    return showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime.parse('2000-01-01'),
      initialDate: DateTime.now(),
    ).then((value) => {
          parseDates(value?.toString() ?? DateTime.now().toString()) ==
                  parseDates(DateTime.now().toString())
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Dates are the same'),
                    duration: Duration(seconds: 2),
                  ),
                )
              : Navigator.push(
                  context,
                  routeTo(
                    APODViewer(
                      date: parseDates(
                          value?.toString() ?? DateTime.now().toString()),
                    ),
                  ),
                ),
        });
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var apodProviderData = watch(apodProvider);
    var whiteBalance = watch(whiteBalanceProvider(
      apodProviderData.mediaType == 'video'
          ? apodProviderData.videoThumb!
          : apodProviderData.image!,
    ));
    return whiteBalance.when(
        data: (wb) => Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: changeColorAppBar(wb),
                ),
                title: Container(
                  child: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    centerTitle: true,
                    title: Text(
                      'Picture of the day',
                      style: TextStyle(
                        color: changeColorAppBar(wb),
                      ),
                    ),
                  ),
                ),
                flexibleSpace: Consumer(
                  builder: (context, watch, child) {
                    var provider = watch(blurhashProvider(
                      apodProviderData.mediaType == 'video'
                          ? apodProviderData.videoThumb!
                          : apodProviderData.image!,
                    ));
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
                    onTap: () {
                      _openDialog(context);
                    },
                    borderRadius: BorderRadius.circular(180),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: Icon(
                          Icons.event_rounded,
                          color: changeColorAppBar(wb),
                        ),
                      ),
                    ),
                  ),
                  DownloadButton(
                    whiteBalance: wb,
                    imageUrl: apodProviderData.hdUrl,
                    mediaType: apodProviderData.mediaType,
                  ),
                ],
              ),
              body: APODContents(),
            ),
        loading: () => Scaffold(body: flareLoadingAnimation()),
        error: (e, s) => Text('Error'));
  }
}

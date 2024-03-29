import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:spaceportal/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spaceportal/pages/mars_rover_page/image_viewer/components/mars_rover_stats.dart';

class ImageViewer extends StatelessWidget {
  ImageViewer(
      {this.index,
      this.list,
      this.earthDate,
      this.cameraName,
      this.roverName,
      this.status});

  final list;
  final index;
  final earthDate;
  final roverName;
  final status;
  final cameraName;

  final double buttonHeight = 50;
  final double buttonWidth = 130;

  void downloadImage(context) async {
    await ImageDownloader.downloadImage(
      list,
      destination: AndroidDestinationType.directoryDownloads,
    );
    ImageDownloader.callback(
      onProgressUpdate: (id, progress) {
        if (progress == 100) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 2),
              content: Text(
                'Download Complete',
                style: kDetailsTS.copyWith(color: Colors.white),
              ),
            ),
          );
        }
      },
    );
  }

  createDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        var theme = Theme.of(context);
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Download Confirmation',
                  style: theme.textTheme.headline6,
                ),
                Text(
                  'Do you want to download?',
                  style: theme.textTheme.subtitle1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: buttonHeight,
                        width: buttonWidth,
                        child: TextButton(
                          style: theme.textButtonTheme.style,
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: theme.textTheme.button,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 25),
                    Container(
                      height: buttonHeight,
                      width: buttonWidth,
                      child: ElevatedButton(
                        onPressed: () {
                          downloadImage(context);
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download_rounded,
                              color: theme.primaryColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Confirm',
                              style: theme.textTheme.button?.copyWith(
                                color: theme.primaryColor,
                              ),
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              createDialog(context);
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              child: Icon(Icons.get_app),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            InteractiveViewer(
              maxScale: 4,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: CachedNetworkImage(
                    imageUrl: list,
                    //TODO: Get a new Placeholder and Error widgets
                    placeholder: (context, url) => CircularProgressIndicator(
                      color: Colors.black,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.red[100],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                width: (MediaQuery.of(context).size.width),
                // color: Colors.grey[900],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MarsRoverImageStats(
                      text1: 'Rover Name:',
                      text2: '$roverName',
                    ),
                    MarsRoverImageStats(
                      text1: 'Earth Date:',
                      text2: '$earthDate',
                    ),
                    MarsRoverImageStats(
                      text1: 'Camera:',
                      text2: '$cameraName',
                    ),
                    MarsRoverImageStats(
                      text1: 'Status:',
                      text2: '$status',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

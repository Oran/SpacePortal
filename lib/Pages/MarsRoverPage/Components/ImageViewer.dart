import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:spaceportal/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  void downloadImage(context) async {
    await ImageDownloader.downloadImage(
      list,
      destination: AndroidDestinationType.directoryDownloads,
    );
    ImageDownloader.callback(
      onProgressUpdate: (id, progress) {
        if (progress == 100) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Download Complete')),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              downloadImage(context);
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              color: kPrimaryWhite,
              child: Icon(
                Icons.get_app,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: CachedNetworkImage(imageUrl: list),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Rover Name: ', style: kMarsRoverImageStatsTS),
                      Text(
                        '$roverName',
                        style: kMarsRoverImageStatsTS.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Earth Date: ', style: kMarsRoverImageStatsTS),
                      Text(
                        '$earthDate',
                        style: kMarsRoverImageStatsTS.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Camera: ', style: kMarsRoverImageStatsTS),
                      Text(
                        '$cameraName',
                        style: kMarsRoverImageStatsTS.copyWith(
                          fontWeight: FontWeight.w800,
                          //fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Status: ', style: kMarsRoverImageStatsTS),
                      Text(
                        '$status',
                        style: kMarsRoverImageStatsTS.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

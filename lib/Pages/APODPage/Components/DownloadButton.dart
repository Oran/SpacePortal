import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({
    Key? key,
    this.snapshot,
    this.imageUrl,
    this.mediaType,
  }) : super(key: key);

  final snapshot;
  final imageUrl;
  final mediaType;

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  Future<void> downloadImage() async {
    if (widget.mediaType == 'image') {
      var permissionStatus = await Permission.mediaLibrary.status;
      print(permissionStatus);
      if (permissionStatus.isGranted) {
        await ImageDownloader.downloadImage(
          widget.imageUrl,
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
      } else {
        Permission.mediaLibrary.request();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Media can\'t be downloaded')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () => downloadImage(),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Icon(
            Icons.download_rounded,
            color: widget.snapshot.data < 127 ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spaceportal/constants.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({
    Key? key,
    this.snapshotData,
    this.imageUrl,
    this.mediaType,
  }) : super(key: key);

  final snapshotData;
  final imageUrl;
  final mediaType;

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  double buttonHeight = 50;
  double buttonWidth = 130;

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
      } else {
        Permission.mediaLibrary.request();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'Media can\'t be downloaded',
            style: kDetailsTS.copyWith(color: Colors.white),
          ),
        ),
      );
    }
  }

  createDialog() {
    return showDialog(
      context: context,
      builder: (context) {
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
                  style: kDialogBoxTS.copyWith(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Do you want to download?',
                  style: kDialogBoxTS.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
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
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: kDialogBoxTS.copyWith(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 25),
                    InkWell(
                      onTap: () {
                        downloadImage();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: buttonHeight,
                        width: buttonWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: kAccentColor),
                          color: kAccentColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download_rounded,
                              color: kIconColor,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Confirm',
                              style: kDialogBoxTS.copyWith(
                                color: kPrimaryWhite,
                                fontSize: 17,
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
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      onTap: () => createDialog(),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Icon(
            Icons.download_rounded,
            color: widget.snapshotData < 127 ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}

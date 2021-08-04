import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spaceportal/constants.dart';
import 'package:spaceportal/utils/functions.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({
    Key? key,
    this.whiteBalance,
    this.imageUrl,
    this.mediaType,
  }) : super(key: key);

  final whiteBalance;
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
                  content: Text('Download Complete'),
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
          content: Text('Media can\'t be downloaded'),
        ),
      );
    }
  }

  createDialog() {
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
                          downloadImage();
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
    return InkWell(
      borderRadius: BorderRadius.circular(60),
      onTap: () => createDialog(),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Icon(
            Icons.download_rounded,
            color: changeColorAppBar(widget.whiteBalance),
          ),
        ),
      ),
    );
  }
}

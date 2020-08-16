import 'package:SpacePortal/constants.dart';

class FSData {
  FSData({
    this.title = '',
    this.date = '',
    this.exp = '',
    this.image = kPlaceholderImage,
    this.mediaType = '',
    this.testf = '',
    this.videoURL = ' ',
  });
  
  String title;
  String date;
  String image;
  String mediaType;
  String exp;
  String testf;
  String videoURL;
}

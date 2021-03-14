import 'package:SpacePortal/Constants.dart';

class FSData {
  FSData({
    this.title = '',
    this.date = '',
    this.exp = '',
    this.image = kPlaceholderImage,
    this.mediaType = '',
    this.testf = '',
    this.videoURL = '',
    this.apodSite = '',
  });

  String? title;
  String? date;
  String? image;
  String? mediaType;
  String? exp;
  String testf;
  String? videoURL;
  String? apodSite;
}

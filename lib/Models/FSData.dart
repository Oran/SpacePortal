import 'package:spaceportal/Constants.dart';

class CachedData {
  CachedData({
    this.title = '',
    this.date = '',
    this.exp = '',
    this.image = kPlaceholderImage,
    this.mediaType = '',
    this.testf = '',
    this.videoURL = '',
    this.apodSite = '',
    this.hdUrl = '',
    this.videoThumb = '',
  });

  String? title;
  String? date;
  String? image;
  String? mediaType;
  String? exp;
  String testf;
  String? videoURL;
  String? apodSite;
  String? hdUrl;
  String? videoThumb;

  factory CachedData.fromJson(Map<String, dynamic> map) {
    return CachedData(
      apodSite: map['apodSite'],
      date: map['date'],
      exp: map['description'],
      image: map['image'],
      mediaType: map['mediaType'],
      title: map['title'],
      videoURL: map['videoUrl'],
      hdUrl: map['hdurl'],
      videoThumb: map['videoThumb'],
    );
  }

  get data => null;
}

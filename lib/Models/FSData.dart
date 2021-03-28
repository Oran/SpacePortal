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
    );
  }

  get data => null;
}

import 'package:SpacePortal/Constants.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

class OldNasaData {
  OldNasaData({
    this.title = '',
    this.date = '',
    this.exp = '',
    this.image = kPlaceholderImage,
    this.mediaType = '',
    this.testf = '',
    this.apodSite = '',
    this.videoURL = '',
    this.videoThumb = '',
  });
  String? title;
  String? date;
  String? image;
  String? mediaType;
  String? exp;
  String testf;
  String? videoURL;
  String videoThumb;
  String? apodSite;

  factory OldNasaData.fromJson(Map<String, dynamic> map) {
    String getThumbnail(String videoURL) {
      RegExp exp = RegExp(r"embed\/([^#\&\?]{11})");
      String videoID = exp.firstMatch(videoURL)!.group(1)!;
      var videoImage = yt.ThumbnailSet(videoID).highResUrl;
      return videoImage;
    }

    // Checks if the 'url' key is present
    bool _checkKey(Map map) {
      return map.containsKey('url');
    }

    //print(_checkKey(map));

    return OldNasaData(
      title: map['title'],
      date: map['date'],
      image: _checkKey(map) ? map['url'] : kPlaceholderImage,
      mediaType: map['media_type'],
      exp: map['description'],
      apodSite: map['apod_site'],
      videoURL: _checkKey(map) ? map['url'] : kPlaceholderImage,
      videoThumb: map['media_type'] == 'video'
          ? getThumbnail(map['url'])
          : kPlaceholderImage,
    );
  }
}
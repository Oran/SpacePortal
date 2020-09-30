import 'package:SpacePortal/constants.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

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

class OldNasaData {
  OldNasaData({
    this.title = '',
    this.date = '',
    this.exp = '',
    this.image = kPlaceholderImage,
    this.mediaType = '',
    this.testf = '',
    this.videoURL = '',
    this.videoThumb = '',
  });
  String title;
  String date;
  String image;
  String mediaType;
  String exp;
  String testf;
  String videoURL;
  String videoThumb;

  factory OldNasaData.fromJson(Map<String, dynamic> map) {
    String getThumbnail(String videoURL) {
      RegExp exp = RegExp(r"embed\/([^#\&\?]{11})");
      String videoID = exp.firstMatch(videoURL).group(1);
      var videoImage = yt.ThumbnailSet(videoID).maxResUrl;
      return videoImage;
    }

    return OldNasaData(
      title: map['title'],
      date: map['date'],
      image: map['url'],
      mediaType: map['media_type'],
      exp: map['explanation'],
      videoURL: map['url'],
      videoThumb: map['media_type'] == 'video' ? getThumbnail(map['url']) : '',
    );
  }
}

class MarsWeather {
  var listDays;

  MarsWeather({this.listDays});

  factory MarsWeather.fromJson(Map<String, dynamic> map) {
    return MarsWeather(
      listDays:
          map['sol_keys'].map((day) => SolDays.fromMap(map[day], day)).toList(),
    );
  }
}

class SolDays {
  String day;
  var av;
  var ct;
  var mn;
  var mx;
  String season;

  SolDays({
    this.av,
    this.ct,
    this.day,
    this.mn,
    this.mx,
    this.season,
  });

  factory SolDays.fromMap(Map<String, dynamic> map, String d) {
    return SolDays(
      day: d,
      av: map['AT']['av'], // Average temp in F
      ct: map['AT']['ct'], // recorded samples over the sol
      mn: map['AT']['mn'], // Min Temp
      mx: map['AT']['mx'], // Max Temp
      season: map['Season'], // Current Season
    );
  }
}

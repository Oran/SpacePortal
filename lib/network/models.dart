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
    int _convertTemp(double temp) {
      var result = (temp - 32) * 5 / 9;
      return result.round();
    }

    return SolDays(
      day: d,
      av: _convertTemp(map['AT']['av']), // Average temp in F
      ct: map['AT']['ct'], // recorded samples over the sol
      mn: _convertTemp(map['AT']['mn']), // Min Temp
      mx: _convertTemp(map['AT']['mx']), // Max Temp
      season: map['Season'], // Current Season
    );
  }
}

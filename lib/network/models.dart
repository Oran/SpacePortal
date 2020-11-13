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
  var numOfDays;
  var weatherData;

  MarsWeather({this.listDays, this.numOfDays, this.weatherData});

  factory MarsWeather.fromJson(Map<String, dynamic> map) {
    int days = map['sol_keys'].length;
    List _listOfDays = map['sol_keys'].toList();
    bool isThere;

    // Checks if the keys are null
    try {
      for (var i = 0; i <= days - 1; i++) {
        var x = map[_listOfDays[i]].containsKey('AT');
        var y = map[_listOfDays[i]]['WD'].containsValue(null);
        // print('${_listOfDays[i]} AT ?there => $x , WD ?null => $y');

        if (x == true && y == true) {
          isThere = true;
        } else {
          isThere = false;
        }
      }

      // if (isThere) {
      //   print('Data is there');
      // } else {
      //   print('Data is not there');
      // }
    } catch (e) {
      print(e);
    }

    return MarsWeather(
      listDays:
          map['sol_keys'].map((day) => SolDays.fromMap(map[day], day)).toList(),
      // numOfDays: isThere,
      weatherData: isThere,
    );
  }
}

class SolDays {
  String day;
  var av;
  var mn;
  var mx;
  String season;
  var wd;

  SolDays({
    this.av,
    this.day,
    this.mn,
    this.mx,
    this.season,
    this.wd,
  });

  factory SolDays.fromMap(Map<String, dynamic> map, String d) {
    int _convertTemp(double temp) {
      var result = (temp - 32) * 5 / 9;
      return result.round();
    }

    //* Real Data
    // return SolDays(
    //   day: d,
    //   av: _convertTemp(map['AT']['av']),
    //   mn: _convertTemp(map['AT']['mn']), // Min Temp
    //   mx: _convertTemp(map['AT']['mx']), // Max Temp
    //   season: map['Season'], // Current Season
    //   wd: map['WD']['most_common']['compass_degrees'],
    // );

    //* Fake Data
    return SolDays(
      day: d,
      av: _convertTemp(89), // recorded samples over the sol
      mn: _convertTemp(70), // Min Temp
      mx: _convertTemp(120), // Max Temp
      season: 'Summer', // Current Season
      wd: 100,
    );
  }
}

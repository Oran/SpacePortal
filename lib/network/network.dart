import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';

final String _apiKey = 'pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3';

class NasaPODData {
  static String url = 'https://api.nasa.gov/planetary/apod?api_key=$_apiKey';

  Future getData() async {
    var box = Hive.box('cache');
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    var image = decodedData['url'];
    var title = decodedData['title'];
    var date = decodedData['date'];
    var exp = decodedData['explanation'];
    var mediaType = decodedData['media_type'];
    var statusCode = decodedData['code'];
    var msg = decodedData['msg'];
    print(statusCode);
    if (statusCode != 404) {
      box.put('image', image);
      box.put('title', title);
      box.put('date', date);
      box.put('exp', exp);
    }
    return [image, title, date, exp, mediaType, statusCode, msg];
  }
}

final List<String> cam = [
  'fhaz',
  'rhaz',
  'mast',
  'chemcam',
  'mahil',
  'mardi',
  'navcam',
  'pancam',
  'minites',
];

final List<String> rover = [
  'curiosity',
  'opportunity',
  'spirit',
];

String url =
    'https://api.nasa.gov/mars-photos/api/v1/rovers/${rover[1]}/photos?sol=100&camera=${cam[6]}&api_key=$_apiKey';

class NasaMarsData {
  void printURL() {
    print(url);
  }

  void setURL(camIn, roverIn, solIn) {
    url =
        'https://api.nasa.gov/mars-photos/api/v1/rovers/$roverIn/photos?sol=$solIn&camera=$camIn&api_key=$_apiKey';
  }

  Future getMarsData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    return decodedData;
  }
}

class SpaceXData {
  static String url = 'https://api.spacexdata.com/v3/launches/upcoming';

  Future getData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    return decodedData;
  }

  String parseString(String dateTime) {
    RegExp exp = RegExp(r"(\d\d\d\d-\d\d-\d\d)");
    String date = exp.firstMatch(dateTime).group(1);
    return date;
  }
}

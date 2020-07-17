import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

final String _apiKey = 'pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3';

class NasaPODData {
  static String url = 'https://api.nasa.gov/planetary/apod?api_key=$_apiKey';

  Future getData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    var image = decodedData['url'];
    var title = decodedData['title'];
    var date = decodedData['date'];
    var exp = decodedData['explanation'];
    return [image, title, exp, date, response.statusCode];
  }
}

class NasaMarsData {
  static List cam = [
    'fhaz',
    'rhaz',
    'mast',
    'chemcam',
    'mahil',
    'mardi',
    'navcam',
    'pancam',
    'minites'
  ];
  static String url =
      'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=${cam[1]}&api_key=$_apiKey';

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

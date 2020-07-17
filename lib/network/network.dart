import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';

final String _apiKey = 'pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3';

class NasaData {
//"https://api.nasa.gov/planetary/apod?api_key=pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3"

  static String url = 'https://api.nasa.gov/planetary/apod?api_key=$_apiKey';

  Future getData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);

    var image = decodedData['url'];
    var title = decodedData['title'];
    var date = decodedData['date'];
    var exp = decodedData['explanation'];

    //print(response.statusCode);

    return [image, title, exp, date, response.statusCode];
  }
}

class NasaMarsData {
  static String cam = 'navcam';
  static String url =
      'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&camera=$cam&api_key=$_apiKey';

  Future getMarsData() async {
    http.Response response = await http.get(url);

    var decodedData = jsonDecode(response.body);
    return decodedData;
  }
}

class SpaceXData {
  static String url = 'https://api.spacexdata.com/v3/launches/upcoming';

  // Future getSpaceXData() async {
  //   http.Response response = await http.get(url);
  //   var decodedData = jsonDecode(response.body);
  //   var missionName = decodedData[0]['mission_name'];
  //   var flightNumber = decodedData[0]['flight_number'];
  //   var dateTime = decodedData[0]['launch_date_utc'];

  //   RegExp exp = RegExp(r"(\d\d\d\d-\d\d-\d\d)");

  //   String date = exp.firstMatch(dateTime).group(1);

  //   return [missionName, flightNumber, date];
  // }

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

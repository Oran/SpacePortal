import 'package:http/http.dart' as http;
import 'dart:convert';

class NasaData {
//"https://api.nasa.gov/planetary/apod?api_key=pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3"

  static String apiKey = 'pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3';
  static String url = 'https://api.nasa.gov/planetary/apod?api_key=$apiKey';

  Future getData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);

    var image = decodedData['url'];
    var title = decodedData['title'];
    var date = decodedData['date'];
    var exp = decodedData['explanation'];

    List list = [image, title, exp, date];

    // print(response.body);
    //print(list[0]);

    return list;
  }
}

class SpaceXData {
  static String url = 'https://api.spacexdata.com/v3/launches/upcoming';

  Future getSpaceXData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    var missionName = decodedData[0]['mission_name'];

    print(missionName);

    return missionName;
  }
}

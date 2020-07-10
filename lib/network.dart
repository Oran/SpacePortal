import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkData {
//"https://api.nasa.gov/planetary/apod?api_key=pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3"

  static String apiKey = 'pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3';
  static String url = 'https://api.nasa.gov/planetary/apod?api_key=$apiKey';

  Future getData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);

    var image = decodedData['url'];

    // print(response.body);

    return image;
  }
}

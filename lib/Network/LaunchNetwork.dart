import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spaceportal/Models/LaunchData.dart';
import 'data.dart';

class LaunchNetwork {
  Future getData() async {
    // Uri url = Uri.https(
    //   'll.thespacedevs.com',
    //   '/2.2.0/launch/upcoming/',
    //   {'format': 'json', 'limit': '20'},
    // );
    // http.Response response = await http.get(url);
    // var decodedData = jsonDecode(response.body);

    // For testing purposes use offline data
    var decodedData = jsonData;
    var data = Launches.fromList(decodedData['results']);
    print(data.launchData[0].slug);
  }
}

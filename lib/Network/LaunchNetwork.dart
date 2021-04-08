import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spaceportal/Models/LaunchData.dart';
import 'package:localstorage/localstorage.dart';

final storage = LocalStorage('data.json');

class LaunchNetwork {
  Future setDataToCache() async {
    DateTime currentDateTime = DateTime.now();
    DateTime cacheDate = DateTime.parse(storage.getItem('date'));
    Duration difference = currentDateTime.difference(cacheDate);

    // Checks if the time difference is -12 hours
    if (difference.inHours >= 12) {
      Uri url = Uri.https(
        'll.thespacedevs.com',
        '/2.2.0/launch/upcoming/',
        {'format': 'json', 'limit': '20'},
      );
      // gets data from API
      http.Response response = await http.get(url);
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      // Caches http data to database
      await storage.setItem('launchData', decodedData);
      // Caches the current time
      storage.setItem('date', currentDateTime.toString());
    }
  }

  /// gets launch data from cache
  Launches getDataFromCache() {
    var cacheData = storage.getItem('launchData');
    var data = Launches.fromList(cacheData['results']);
    return data;
  }
}

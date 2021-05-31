import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spaceportal/Models/LaunchData.dart';
import 'package:hive/hive.dart';

class LaunchNetwork {
  Future setDataToCache() async {
    await Hive.openBox('launchCacheBox');

    DateTime currentDateTime = DateTime.now();
    var box = Hive.box('launchCacheBox');

    var newUnparsedDate = box.get(
      'launchDate',
      defaultValue: '2020-12-07T16:34:00Z',
    );

    DateTime cacheDate = DateTime.parse(newUnparsedDate);
    Duration difference = currentDateTime.difference(cacheDate);

    print(cacheDate);
    print('Diff => ' + difference.inSeconds.toString());

    // Checks if the time difference is greater than 12 hours
    if (difference.inHours >= 12) {
      Uri url = Uri.https(
        'll.thespacedevs.com',
        '/2.2.0/launch/upcoming/',
        {
          'format': 'json',
          'limit': '15',
          'hide_recent_previous': 'true',
        },
      );
      // gets data from API
      http.Response response = await http.get(url);
      print('api request made');
      Map<String, dynamic> decodedData = jsonDecode(response.body);

      // Caches the data and the current time
      if (box.isOpen) {
        box.put('launchCache', decodedData);
        box.put('launchDate', currentDateTime.toString());
      }
    }
  }

  /// gets launch data from cache
  Launches getDataFromCache() {
    var box = Hive.box('launchCacheBox');
    var cacheData = box.get('launchCache');
    //TODO: Fix if api is down (gives out null errors)
    var data = Launches.fromList(cacheData['results']);
    return data;
  }
}

class ServiceProviderNetwork {
  Future getData(String url, int? id) async {
    await Hive.openBox('ServiceProviderCache');
    var box = Hive.box('ServiceProviderCache');

    if (id != null) {
      // Checks if the cache exists for the specified id
      if (box.containsKey(id)) {
        // If true, sends data from cache

        // if (timediff >= 12hrs){
        //   get data from api
        // } else {
        //   returns the data from cache
        //   and updates with current date and time
        // }

        print('key exists, gets from cache');
        return box.get(id);
      } else {
        print('key doesnt exits, gets from api');

        // Fetches data from the api
        Uri parsedUrl = Uri.parse(url);
        http.Response response = await http.get(parsedUrl);
        var decodedData = jsonDecode(response.body);

        // Adds the data to the local database cache
        box.put(id, decodedData);
        return box.get(id);
      }
    } else {
      print('url is null || id is null');
    }
  }
}

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:spaceportal/Models/FSData.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:spaceportal/Models/OldNasaData.dart';
import 'package:http/http.dart' as http;
import 'package:spaceportal/Utils/Functions.dart';
import 'package:instant/instant.dart';

Uri nasaPodUrl = Uri.https('apodapi.herokuapp.com', '/api',
    {'date': '${parseDates(DateTime.now().toString())}'});

class OldAPODData {
  void setURL(String? date) {
    // nasaPodUrl =
    //     'https://api.nasa.gov/planetary/apod?api_key=$_apiKey&date=$date';
    nasaPodUrl = Uri.https('apodapi.herokuapp.com', '/api', {'date': '$date'});
  }

  Future<dynamic> getOldNasaPodData() async {
    http.Response response = await http.get(nasaPodUrl);
    var decodedData = jsonDecode(response.body);
    var data = OldNasaData.fromJson(decodedData);
    var wb = await checkImgColor(
        data.mediaType == 'image' ? data.image! : data.videoThumb);
    return [data, wb];
  }
}

class APODData {
  // static String url = 'https://api.nasa.gov/planetary/apod?api_key=$_apiKey';
  final Uri url = Uri.https('apodapi.herokuapp.com', '/api');

  String edtDate = dateTimeToZone(
    zone: 'EDT',
    datetime: DateTime.now(),
  ).toString();

  //TODO: Change the caching database to hive
  /// checks for dates and sets data to cache.
  Future setDataToCache() async {
    // print(cacheData.getValue('date'));
    // print(cacheData.appConfig);

    await Hive.openBox('apodcache');
    var box = Hive.box('apodcache');

    // sets default date
    box.get('date', defaultValue: '2021-03-19');

    if (box.get('date') != edtDate.split(' ')[0]) {
      print('apod api http request made');
      http.Response response = await http.get(url);
      Map decodedData = jsonDecode(response.body);

      //TODO: Add defaults data
      print('adding apod data to cache');
      box.put('date', decodedData['date']);
      box.put('title', decodedData['title']);
      box.put('mediaType', decodedData['mediaType']);
      box.put('description', decodedData['description']);
      box.put('apodsite', decodedData['apod_site']);

      if (decodedData['media_type'] == 'image') {
        box.put('image', decodedData['url']);
        box.put('hdurl', decodedData['hdurl']);
      }
      if (decodedData['media_type'] == 'video') {
        getThumbnail(decodedData['url']);
      }
    }
  }

  /// get video thumbnail and send it to firestore
  void getThumbnail(String videoURL) {
    var box = Hive.box('apodcache');
    //TODO Add check if different url other than youtube

    box.put('videoUrl', videoURL);

    RegExp exp = RegExp(r"embed\/([^#\&\?]{11})");
    String videoID = exp.firstMatch(videoURL)!.group(1)!;

    var videoImageUrl = yt.ThumbnailSet(videoID).highResUrl;
    //! This breaks and the videoURL is not updated

    box.put('videoThumb', videoImageUrl);
  }

  CachedData getDataFromCache() {
    var box = Hive.box('apodcache');
    Map<String, dynamic> cachedDataMap = {
      "title": box.get('title'),
      "date": box.get('date'),
      "image": box.get('image'),
      "hdurl": box.get('hdurl'),
      "mediaType": box.get('mediaType'),
      "videoThumb": box.get('videoThumb'),
      "videoUrl": box.get('videoUrl'),
      "apodSite": box.get('apodsite'),
      "description": box.get('description'),
    };

    var data = CachedData.fromJson(cachedDataMap);
    return data;
  }
}

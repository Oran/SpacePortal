import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:spaceportal/constants.dart';
import 'package:spaceportal/models/apod_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:http/http.dart' as http;
import 'package:spaceportal/utils/functions.dart';
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

  /// Opens hive box
  Future openHiveBox() async {
    await Hive.openBox('apodcache');
  }

  /// checks for dates and sets data to cache.
  Future setDataToCache() async {
    // print(cacheData.getValue('date'));
    // print(cacheData.appConfig);

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
      box.put('mediaType', decodedData['media_type']);
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
    //TODO: This needs better default values
    Map<String, dynamic> cachedDataMap = {
      "title": box.get('title', defaultValue: 'Title => Null'),
      "date": box.get('date', defaultValue: 'Date => Null'),
      "image": box.get('image', defaultValue: kPlaceholderImage),
      "hdurl": box.get('hdurl', defaultValue: kPlaceholderImage),
      "mediaType": box.get('mediaType', defaultValue: 'image'),
      "videoThumb": box.get('videoThumb', defaultValue: kPlaceholderImage),
      "videoUrl": box.get(
        'videoUrl',
        defaultValue: 'https://www.youtube.com/embed/WJua8eXLX9o?rel=0',
      ),
      "apodSite": box.get('apodsite', defaultValue: 'site is null'),
      "description": box.get('description', defaultValue: 'Null'),
    };

    var data = CachedData.fromJson(cachedDataMap);
    return data;
  }
}

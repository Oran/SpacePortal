import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:spaceportal/Models/FSData.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:spaceportal/Models/OldNasaData.dart';
import 'package:http/http.dart' as http;
import 'package:spaceportal/Functions.dart';
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
  GlobalConfiguration cacheData = GlobalConfiguration();
  String edtDate = dateTimeToZone(
    zone: 'EDT',
    datetime: DateTime.now(),
  ).toString();

  /// checks for dates and sets data to cache.
  Future setDataToCache() async {
    // print(cacheData.getValue('date'));
    // print(cacheData.appConfig);
    if (cacheData.getValue('date') != edtDate.split(' ')[0]) {
      http.Response response = await http.get(url);
      Map decodedData = jsonDecode(response.body);
      cacheData..updateValue('date', decodedData['date']);
      cacheData..updateValue('title', decodedData['title']);
      //cacheData..updateValue('image', decodedData['url']);
      cacheData..updateValue('mediaType', decodedData['media_type']);
      cacheData..updateValue('description', decodedData['description']);
      cacheData..updateValue('hdurl', decodedData['hdurl']);

      if (decodedData['media_type'] == 'image') {
        cacheData..updateValue('image', decodedData['url']);
      }
      if (decodedData['media_type'] == 'video') {
        getThumbnail(decodedData['url']);
      }
    }
  }

  /// get video thumbnail and send it to firestore
  void getThumbnail(String videoURL) {
    RegExp exp = RegExp(r"embed\/([^#\&\?]{11})");
    String videoID = exp.firstMatch(videoURL)!.group(1)!;
    var videoImageUrl = yt.ThumbnailSet(videoID).highResUrl;
    cacheData..updateValue('video', videoImageUrl);
  }

  CachedData getDataFromCache() {
    var data = CachedData.fromJson(cacheData.appConfig);
    return data;
  }
}

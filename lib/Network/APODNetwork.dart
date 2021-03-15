import 'dart:convert';
import 'package:spaceportal/Models/FSData.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;
import 'package:spaceportal/Models/OldNasaData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:spaceportal/Functions.dart';
import 'package:image/image.dart';

Uri nasaPodUrl = Uri.https('apodapi.herokuapp.com', '/api',
    {'date': '${parseDates(DateTime.now().toString())}'});

class OldAPODData {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getData() async {
    var response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    var image = decodedData['url'];
    var title = decodedData['title'];
    var date = decodedData['date'];
    var exp = decodedData['description'];
    var mediaType = decodedData['media_type'];
    var apodSite = decodedData['apod_site'];
    //var statusCode = response.statusCode;
    if (true) {
      if (mediaType == 'image') {
        firestore.collection('api').doc('nasa_api').update({'image': image});
      }
      firestore.collection('api').doc('nasa_api').update({
        'date': date,
        'title': title,
        'exp': exp,
        'mediaType': mediaType,
        'apodSite': apodSite,
        // 'test_f': 'old data',
      });
    }
    if (mediaType == 'video') {
      getThumbnail(image);
    }
  }

  void getThumbnail(String videoURL) {
    RegExp exp = RegExp(r"embed\/([^#\&\?]{11})");
    String videoID = exp.firstMatch(videoURL)!.group(1)!;
    var videoImage = yt.ThumbnailSet(videoID).highResUrl;
    firestore.collection('api').doc('nasa_api').update({
      'image': videoImage,
      'videoURL': videoURL,
    });
  }

  Future checkImgColor(String url) async {
    var response = await http.get(Uri.parse(url));
    int whiteBalance = decodeImage(response.bodyBytes)!.getWhiteBalance();
    return whiteBalance;
  }

  Stream<FSData> getFSData() {
    return firestore.collection('api').doc('nasa_api').snapshots().map(
          (ds) => FSData(
              title: ds['title'],
              date: ds['date'],
              image: ds['image'],
              videoURL: ds['videoURL'],
              exp: ds['exp'],
              mediaType: ds['mediaType'],
              apodSite: ds['apodSite']
              // testf: ds['test_f'],
              ),
        );
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:SpacePortal/network/models.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

final String _apiKey = 'pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3';

class NasaPODData {
  static String url = 'https://api.nasa.gov/planetary/apod?api_key=$_apiKey';
  Firestore firestore = Firestore.instance;

  Future getData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    var image = decodedData['url'];
    var title = decodedData['title'];
    var date = decodedData['date'];
    var exp = decodedData['explanation'];
    var mediaType = decodedData['media_type'];
    var statusCode = decodedData['code'];
    //print(statusCode);
    if (statusCode != 404) {
      if (mediaType == 'image') {
        firestore
            .collection('api')
            .document('nasa_api')
            .updateData({'image': image});
      }
      firestore.collection('api').document('nasa_api').updateData({
        'date': date,
        'title': title,
        'exp': exp,
        'mediaType': mediaType,
        // 'test_f': 'old data',
      });
    }
    if (mediaType == 'video') {
      getThumbnail(image);
    }
  }

  void getThumbnail(String videoURL) {
    RegExp exp = RegExp(r"embed\/([^#\&\?]{11})");
    String videoID = exp.firstMatch(videoURL).group(1);
    var videoImage = yt.ThumbnailSet(videoID).maxResUrl;
    firestore.collection('api').document('nasa_api').updateData({
      'image': videoImage,
      'videoURL': videoURL,
    });
  }

  Stream<FSData> getFSData() {
    return firestore.collection('api').document('nasa_api').snapshots().map(
          (ds) => FSData(
            title: ds['title'],
            date: ds['date'],
            image: ds['image'],
            videoURL: ds['videoURL'],
            exp: ds['exp'],
            mediaType: ds['mediaType'],
            // testf: ds['test_f'],
          ),
        );
  }
}

final List<String> cam = [
  'fhaz',
  'rhaz',
  'mast',
  'chemcam',
  'mahil',
  'mardi',
  'navcam',
  'pancam',
  'minites',
];

final List<String> rover = [
  'curiosity',
  'opportunity',
  'spirit',
];

String url =
    'https://api.nasa.gov/mars-photos/api/v1/rovers/${rover[1]}/photos?sol=100&camera=${cam[6]}&api_key=$_apiKey';

class NasaMarsData {
  void printURL() {
    print(url);
  }

  void setURL(camIn, roverIn, solIn) {
    url =
        'https://api.nasa.gov/mars-photos/api/v1/rovers/$roverIn/photos?sol=$solIn&camera=$camIn&api_key=$_apiKey';
  }

  Future getMarsData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    return decodedData;
  }
}

class SpaceXData {
  static String url = 'https://api.spacexdata.com/v3/launches/upcoming';

  Future<List<dynamic>> getData() async {
    http.Response response = await http.get(url);
    List<dynamic> decodedData = jsonDecode(response.body);
    //print(decodedData);
    return decodedData;
  }

  String parseString(String dateTime) {
    RegExp exp = RegExp(r"(\d\d\d\d-\d\d-\d\d)");
    String date = exp.firstMatch(dateTime).group(1);
    return date;
  }
}

class MarsWeatherAPI {
  static String url =
      'https://api.nasa.gov/insight_weather/?api_key=$_apiKey&feedtype=json&ver=1.0';

  Future<MarsWeather> getMarsWeather() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    var mars = MarsWeather.fromJson(decodedData);
    print(mars.listDays[0].av);
    return mars;
  }
}

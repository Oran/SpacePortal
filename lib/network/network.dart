import 'dart:async';
import 'dart:convert';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/models.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image/image.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

final String _apiKey = 'pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3';

String? parseString(String dateTime) {
  RegExp exp = RegExp(r"(\d\d\d\d-\d\d-\d\d)");
  String? date = exp.firstMatch(dateTime)!.group(1);
  return date;
}

// String nasaPodUrl =
//     'https://api.nasa.gov/planetary/apod?api_key=$_apiKey&date=${parseString(DateTime.now().toString())}';

String nasaPodUrl =
    'http://10.0.2.2:3000/api/?date=${parseString(DateTime.now().toString())}';

class OldNasaPodData {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void setURL(String? date) {
    // nasaPodUrl =
    //     'https://api.nasa.gov/planetary/apod?api_key=$_apiKey&date=$date';
    nasaPodUrl = 'http://10.0.2.2:3000/api/?date=$date';
  }

  Future checkImgColor(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    int whiteBalance = decodeImage(response.bodyBytes)!.getWhiteBalance();
    return whiteBalance;
  }

  Future<dynamic> getOldNasaPodData() async {
    http.Response response = await http.get(Uri.parse(nasaPodUrl));
    var decodedData = jsonDecode(response.body);
    var data = OldNasaData.fromJson(decodedData);
    var wb = await checkImgColor(
        data.mediaType == 'image' ? data.image! : data.videoThumb);
    return [data, wb];
  }
}

class NasaPODData {
  // static String url = 'https://api.nasa.gov/planetary/apod?api_key=$_apiKey';
  static String url = 'http://10.0.2.2:3000/api/';
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getData() async {
    var response = await http.get(Uri.parse(url));
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

String marsUrl =
    'https://api.nasa.gov/mars-photos/api/v1/rovers/${rover[1]}/photos?sol=100&camera=${cam[6]}&api_key=$_apiKey';

class NasaMarsData {
  void printURL() {
    print(marsUrl);
  }

  void setURL(camIn, roverIn, solIn) {
    marsUrl =
        'https://api.nasa.gov/mars-photos/api/v1/rovers/$roverIn/photos?sol=$solIn&camera=$camIn&api_key=$_apiKey';
  }

  Future getMarsData() async {
    Uri _marsUri = Uri.parse(marsUrl);
    http.Response response = await http.get(_marsUri);
    var decodedData = jsonDecode(response.body);
    return decodedData;
  }
}

class SpaceXData {
  static String url = 'https://api.spacexdata.com/v3/launches/upcoming';

  Future<List<dynamic>?> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    List<dynamic>? decodedData = jsonDecode(response.body);
    //print(decodedData);
    return decodedData;
  }

  String? parseString(String dateTime) {
    RegExp exp = RegExp(r"(\d\d\d\d-\d\d-\d\d)");
    String? date = exp.firstMatch(dateTime)!.group(1);
    return date;
  }
}

class MarsWeatherAPI {
  static String url =
      'https://api.nasa.gov/insight_weather/?api_key=$_apiKey&feedtype=json&ver=1.0';

  Future<MarsWeather> getMarsWeather() async {
    http.Response response = await http.get(Uri.parse(url));
    var decodedData = jsonDecode(response.body);
    var mars = MarsWeather.fromJson(decodedData);
    return mars;
  }
}

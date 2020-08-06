import 'package:SpacePortal/network/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as yt;

final String _apiKey = 'pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3';

class NasaPODData {
  static String url = 'https://api.nasa.gov/planetary/apod?api_key=$_apiKey';
  Firestore firestore = Firestore.instance;
  var box = Hive.box('cache');

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
        box.put('image', image);
        firestore
            .collection('api')
            .document('nasa_api')
            .updateData({'image': image});
      }
      box.put('date', date);
      box.put('title', title);
      box.put('exp', exp);
      box.put('mediaType', mediaType);
      firestore.collection('api').document('nasa_api').updateData({
        'date': date,
        'title': title,
        'exp': exp,
        'mediaType': mediaType,
      });
    }
    if (mediaType == 'video') {
      getThumbnail(image);
    }

    return [mediaType];
  }

  void getThumbnail(String videoURL) {
    var box = Hive.box('cache');
    box.put('videoURL', videoURL);
    RegExp exp = RegExp(r"embed\/([^#\&\?]{11})");
    String videoID = exp.firstMatch(videoURL).group(1);
    var videoImage = yt.ThumbnailSet(videoID).maxResUrl;
    firestore
        .collection('api')
        .document('nasa_api')
        .updateData({'image': videoImage});
    // print(box.get('image'));
  }

  void setFSData() {
    firestore.collection('api').document('nasa_api').updateData({
      'image': box.get('image'),
      'date': box.get('date'),
      'title': box.get('title'),
      'exp': box.get('exp'),
      'mediaType': box.get('mediaType'),
    });
  }

  Stream<APIData> readFSData() {
    return firestore
        .collection('api')
        .document('nasa_api')
        .snapshots()
        .map((ds) => APIData(
              image: ds['image'],
              title: ds['title'],
              date: ds['date'],
              exp: ds['exp'],
              mediaType: ds['mediaType'],
            ));
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

  Future getData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    return decodedData;
  }

  String parseString(String dateTime) {
    RegExp exp = RegExp(r"(\d\d\d\d-\d\d-\d\d)");
    String date = exp.firstMatch(dateTime).group(1);
    return date;
  }
}

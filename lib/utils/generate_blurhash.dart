import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:blurhash_dart/blurhash_dart.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

/// Using the blurhash algorithm gets a hash from given image data.
/// This method is ran in a seperate Isolet
Future<String> computeBlurhash(targetUnit8List) async {
  // Decodes Image from Unit8List
  img.Image? image = img.decodeImage(targetUnit8List);
  //Encodes the given image into hash
  BlurHash? blurhash = BlurHash.encode(image!, numCompX: 5, numCompY: 5);
  // print('hash => ' + blurhash.hash);
  return blurhash.hash;
}

/// Reduces Image size for Blurhash to use/
Future<Uint8List> imageSizeReducer(Uint8List unit8) async {
  var codec = await ui.instantiateImageCodec(
    unit8,
    targetHeight: 10,
    targetWidth: 10,
  );

  var frameInfo = await codec.getNextFrame();
  ui.Image targetUiImage = frameInfo.image;

  ByteData? targetByteData = await targetUiImage.toByteData(
    format: ui.ImageByteFormat.png,
  );

  var targetUnit8List = targetByteData!.buffer.asUint8List();
  return targetUnit8List;
}

/// Gets the data from Isolet
Future<dynamic> setDataToCache(url) async {
  DateTime currentDateTime = DateTime.now();
  var box = Hive.box('blurhash');
  var unParsedDate = box.get('blurDate', defaultValue: '2020-12-07T16:34:00Z');
  DateTime cacheDate = DateTime.parse(unParsedDate);
  Duration difference = currentDateTime.difference(cacheDate);

  // print(difference.inHours);

  if (difference.inHours > 5) {
    box.clear();
    print('Blurbox Cleared');
  }

  if (!box.containsKey(url)) {
    // print(url);
    http.Response response = await http.get(Uri.parse(url));
    Uint8List originalUnit8List = response.bodyBytes;
    // box.put('originalUnit8List', originalUnit8List);
    var targetUnit8List = await imageSizeReducer(originalUnit8List);
    if (!box.containsKey(url)) box.put(url, targetUnit8List);
    // var unit8ListFromDB = box.get(url);
    box.put('blurDate', currentDateTime.toString());
    // return unit8ListFromDB;
  }
}

Future<dynamic> getDataFromCompute(var url) async {
  var box = Hive.box('blurhash');
  box.clear();
  await setDataToCache(url);
  var unit8ListFromDB = box.get(url);
  var hashFromCompute = await compute(computeBlurhash, unit8ListFromDB);
  // print('data from compute => ' + hashFromCompute);
  return hashFromCompute;
}

class BlurH {
  Future<void> openHiveBox() async {
    await Hive.openBox('blurhash');
  }
}

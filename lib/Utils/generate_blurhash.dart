import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
  BlurHash? blurhash = BlurHash.encode(image!, numCompX: 4, numCompY: 3);
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
Future<dynamic> getDataFromCompute(url) async {
  http.Response response = await http.get(Uri.parse(url));
  Uint8List originalUnit8List = response.bodyBytes;

  // Resize Image
  var targetUnit8List = await imageSizeReducer(originalUnit8List);

  //Runs the Isolet and gets the data
  var hashFromCompute = await compute(computeBlurhash, targetUnit8List);

  // print('data from compute => ' + hashFromCompute);
  return hashFromCompute;
}

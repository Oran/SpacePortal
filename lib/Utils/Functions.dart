import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as image;
import 'package:flutter/material.dart';
import 'package:spaceportal/Network/LaunchNetwork.dart';

/// Parses dates using Regex into normal format.
String? parseDates(String dateTime) {
  RegExp exp = RegExp(r"(\d\d\d\d-\d\d-\d\d)");
  String? date = exp.firstMatch(dateTime)!.group(1);
  return date;
}

/// Check WhiteBalance of the provided network image.
Future checkImgColor(String url) async {
  var response = await http.get(Uri.parse(url));
  int whiteBalance = image.decodeImage(response.bodyBytes)!.getWhiteBalance();
  return whiteBalance;
}

/// Gets the height difference based on the provided image
///
/// heightDiff = 150 / imageHeight
double getImgHeightDiff(String url) {
  double heightDiff = 0;
  var image = new Image.network(url);
  image.image.resolve(new ImageConfiguration()).addListener(
    ImageStreamListener(
      (ImageInfo info, bool) {
        heightDiff = (150 / info.image.height);
      },
    ),
  );
  return heightDiff;
}

/// Checks if the offset goes below a certain value
double offsetValue(double offset) {
  if (offset < 0) {
    return -offset.abs();
  } else {
    return offset.abs();
  }
}

/// Convert String date to Local Time
String convertDateToLocal(String date) {
  return DateTime.parse(date).toLocal().toString();
}

/// Seperates date and time
/// returns a list of [date, time]
List<String> parseDateAndTime(String datetime) {
  var date = datetime.split(' ')[0];
  var time = datetime.split(' ')[1].split('.')[0];
  return [date, time];
}

/// returns the time difference from the Current datetime to the provided one.
Duration timeDifference(String time) {
  DateTime currentDateTime = DateTime.now();
  DateTime parsedDate = DateTime.parse(time);
  return currentDateTime.difference(parsedDate).abs();
}

// Checks if the dates are set if not, it will do it.
Future<void> initStorage() async {
  var configs = GlobalConfiguration();
  if (configs.getValue('didRun')) {
    print('Did not run');
  } else {
    storage.setItem('date', '2020-04-07T16:34:00Z');
    configs.updateValue('didRun', true);
    print('Ran');
  }
}
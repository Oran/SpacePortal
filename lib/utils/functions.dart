import 'package:flare_flutter/flare_actor.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as image;
import 'package:flutter/material.dart';

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

// Parses datetime from a different format from API
List<String> parseDT(String dateTime) {
  var date = dateTime.split('T')[0];
  var time = dateTime.split('T')[1].split('Z')[0];
  return [date, time];
}

// Routes to another page with page transition
Route routeTo(var secondPage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => secondPage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

/// Flare loading animation
Widget flareLoadingAnimation() {
  return Center(
    child: Container(
      height: 400.0,
      width: 400.0,
      child: FlareActor(
        'assets/animations/space.flr',
        animation: 'Untitled',
        fit: BoxFit.fill,
      ),
    ),
  );
}

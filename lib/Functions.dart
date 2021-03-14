import 'package:http/http.dart' as http;
import 'package:image/image.dart';

/// Parses dates using Regex into normal format.
String? parseDates(String dateTime) {
  RegExp exp = RegExp(r"(\d\d\d\d-\d\d-\d\d)");
  String? date = exp.firstMatch(dateTime)!.group(1);
  return date;
}

/// Check WhiteBalance of the provided network image.
Future checkImgColor(String url) async {
  var response = await http.get(Uri.parse(url));
  int whiteBalance = decodeImage(response.bodyBytes)!.getWhiteBalance();
  return whiteBalance;
}

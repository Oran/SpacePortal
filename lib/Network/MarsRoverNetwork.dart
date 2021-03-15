import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String _apiKey = 'pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3';

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

Uri marsRoverUrl = Uri.https(
  'api.nasa.gov',
  '/mars-photos/api/v1/rovers/${rover[1]}/photos',
  {
    'sol': '100',
    'camera': '${cam[6]}',
    'api_key': '$_apiKey',
  },
);

class MarsRoverImageData {
  void setURL(camIn, roverIn, solIn) {
    marsRoverUrl = Uri.https(
      'api.nasa.gov',
      '/mars-photos/api/v1/rovers/$roverIn/photos',
      {
        'sol': '$solIn',
        'camera': '$camIn',
        'api_key': '$_apiKey',
      },
    );
  }

  Future getMarsData() async {
    http.Response response = await http.get(marsRoverUrl);
    var decodedData = jsonDecode(response.body);
    return decodedData;
  }
}

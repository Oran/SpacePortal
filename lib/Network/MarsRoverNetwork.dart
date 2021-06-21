import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final String _apiKey = 'pc7RPSAONSoBlJTGozeFT1EcaDa0mwXoD17XsKd3';

final List<String> oldCam = [
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

final List<String> newCam = [
  'EDL_RUCAM',
  'EDL_RDCAM',
  'EDL_DDCAM',
  'EDL_PUCAM1',
  'EDL_PUCAM2',
  'NAVCAM_LEFT',
  'NAVCAM_RIGHT',
  'MCZ_RIGHT',
  'MCZ_LEFT',
  'FRONT_HAZCAM_LEFT_A',
  'FRONT_HAZCAM_RIGHT_A',
  'REAR_HAZCAM_LEFT',
  'REAR_HAZCAM_RIGHT',
  'SKYCAM',
  'SHERLOC_WATSON',
];

final List<String> rover = [
  'curiosity',
  'opportunity',
  'spirit',
  'perseverance'
];

// Uri marsRoverUrl = Uri.https(
//   'api.nasa.gov',
//   '/mars-photos/api/v1/rovers/${rover[0]}/photos',
//   {
//     'sol': '100',
//     'camera': '${oldCam[7]}',
//     'api_key': '$_apiKey',
//   },
// );

Uri marsRoverUrl = Uri.parse(
  'https://api.nasa.gov/mars-photos/api/v1/rovers/perseverance/latest_photos?api_key=$_apiKey',
);

class MarsRoverImageData {
  void setURL(camIn, roverIn, solIn, isLatest) {
    if (isLatest) {
      marsRoverUrl = Uri.parse(
        'https://api.nasa.gov/mars-photos/api/v1/rovers/perseverance/latest_photos?api_key=$_apiKey',
      );
    } else {
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
  }

  Future getMarsData() async {
    http.Response response = await http.get(marsRoverUrl);
    var decodedData = jsonDecode(response.body);
    return decodedData;
  }
}

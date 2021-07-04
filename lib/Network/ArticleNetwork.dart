import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spaceportal/Models/Articles.dart';
import 'package:hive/hive.dart';

class ArticleAPI {
  Uri url = Uri.https('spaceflightnewsapi.net', '/api/v2/articles');

  Future openHiveBox() async {
    await Hive.openBox('articleCache');
  }

  Future setDataToCache() async {
    DateTime currentDateTime = DateTime.now();
    var box = Hive.box('articleCache');

    var unparsedCachedDate = box.get(
      'cacheDate',
      defaultValue: '2020-12-07T16:34:00Z',
    );

    DateTime cacheDate = DateTime.parse(unparsedCachedDate);
    Duration difference = currentDateTime.difference(cacheDate);

    print('articles diff => ${difference.inSeconds}s');

    if (difference.inHours >= 5) {
      http.Response response = await http.get(url);
      var decodedData = jsonDecode(response.body);

      if (box.isOpen) {
        box.put('articleCache', decodedData);
        box.put('cacheDate', currentDateTime.toString());
      }
    }
  }

  Articles getDataFromCache() {
    var box = Hive.box('articleCache');
    var cachedData = box.get('articleCache');
    var modeledData = Articles.fromList(cachedData);
    return modeledData;
  }
}

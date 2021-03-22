import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spaceportal/Models/Articles.dart';

class ArticleAPI {
  Uri url = Uri.https('spaceflightnewsapi.net', '/api/v2/articles');

  Future getNewsData() async {
    http.Response response = await http.get(url);
    var decodedData = jsonDecode(response.body);
    var articles = Articles.fromList(decodedData);
    return articles;
  }
}

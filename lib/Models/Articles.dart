class Articles {
  var data;
  int length;
  Articles({this.data, required this.length});

  factory Articles.fromList(List list) {
    var indexes = list.asMap().keys.toList();
    return Articles(
      data: indexes.map((e) => new ArticleData.fromMap(list[e])).toList(),
      length: list.length,
    );
  }
}

class ArticleData {
  String id;
  String title;
  String url;
  String imageUrl;
  String newsSite;
  String summary;
  String publishedAt;
  String updatedAt;
  bool featured;

  ArticleData({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.featured,
    required this.newsSite,
    required this.publishedAt,
    required this.summary,
    required this.updatedAt,
    required this.url,
  });

  factory ArticleData.fromMap(dynamic map) {
    return ArticleData(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      featured: map['featured'],
      newsSite: map['newsSite'],
      publishedAt: map['publishedAt'],
      summary: map['summary'],
      updatedAt: map['updatedAt'],
      url: map['url'],
    );
  }
}
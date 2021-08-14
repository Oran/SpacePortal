class Articles {
  List data;
  int length;
  Articles({required this.data, required this.length});

  factory Articles.fromList(List list) {
    return Articles(
      data: list.map((article) => ArticleData.fromMap(article)).toList(),
      length: list.length,
    );
  }
}

class ArticleData {
  int id;
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

  factory ArticleData.fromMap(Map<dynamic, dynamic> map) {
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

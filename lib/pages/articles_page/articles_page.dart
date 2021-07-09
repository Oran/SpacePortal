import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/constants.dart';
import 'package:spaceportal/Providers/providers.dart';
import 'package:spaceportal/Widgets/fadein_appbar.dart';
import 'package:spaceportal/pages/articles_page/components/article_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var articles = watch(articleProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryWhite,
        elevation: 0,
        centerTitle: true,
        title: Text('Articles'),
        flexibleSpace: Consumer(
          builder: (context, watch, child) {
            var provider = watch(blurhashProvider(articles.data[0].imageUrl));
            return provider.when(
              data: (data) => FadeInAppBar(value: data),
              loading: () => Container(),
              error: (e, s) {
                print(e);
                print(s);
                return Container(
                  color: Colors.grey[100],
                );
              },
            );
          },
        ),
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 20),
          physics: BouncingScrollPhysics(),
          itemCount: articles.data.length,
          itemBuilder: (context, index) {
            return Container(
              child: ArticleCard(
                image: CachedNetworkImage(
                  imageUrl: articles.data[index].imageUrl,
                  fit: BoxFit.cover,
                  memCacheHeight: 700,
                  memCacheWidth: 1000,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Center(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          value: progress.progress,
                          valueColor: AlwaysStoppedAnimation(Colors.black),
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return FlutterLogo();
                  },
                ),
                text: articles.data[index].title,
                textStyle: kCardTS.copyWith(
                  fontSize: 20,
                ),
                publishedDate: articles.data[index].publishedAt.split('T')[0],
                source: articles.data[index].newsSite,
                height: 250.0,
                onPressed: () {
                  try {
                    launch(
                      articles.data[index].url,
                      forceWebView: true,
                      enableJavaScript: true,
                      enableDomStorage: true,
                    );
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

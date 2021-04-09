import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Pages/ArticlesPage/Components/ArticleCard.dart';
import 'package:spaceportal/Providers/Providers.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var articles = watch(articleProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Articles',
          style: kTitleLargeTS,
        ),
      ),
      body: articles.when(
        data: (data) => Container(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 20),
            physics: BouncingScrollPhysics(),
            itemCount: data.data.length,
            itemBuilder: (context, index) {
              return Container(
                child: ArticleCard(
                  image: CachedNetworkImage(
                    imageUrl: data.data[index].imageUrl,
                    fit: BoxFit.cover,
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
                  text: data.data[index].title,
                  textStyle: kCardTS.copyWith(
                    fontSize: 20,
                  ),
                  publishedDate: data.data[index].publishedAt.split('T')[0],
                  source: data.data[index].newsSite,
                  height: 250.0,
                  onPressed: () {
                    try {
                      launch(
                        data.data[index].url,
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
        error: (error, stackTrace) => Text('Error'),
        loading: () => Center(
          child: Container(
            height: 400.0,
            width: 400.0,
            child: FlareActor(
              'assets/animations/space.flr',
              animation: 'Untitled',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

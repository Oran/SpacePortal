import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/providers/providers.dart';
import 'package:spaceportal/services/ad_helper.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:spaceportal/widgets/ad_widget.dart';
import 'package:spaceportal/widgets/fadein_appbar.dart';
import 'package:spaceportal/pages/articles_page/components/article_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlesPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    var articles = ref.watch(articleProvider);
    var whiteBalance = ref.watch(whiteBalanceProvider(articles.data[0].imageUrl));
    var theme = Theme.of(context);
    return whiteBalance.when(
      data: (wb) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'Articles',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: changeColorAppBar(wb),
            ),
          ),
          iconTheme: IconThemeData(
            color: changeColorAppBar(wb),
          ),
          flexibleSpace: Consumer(
            builder: (context, ref, child) {
              var provider = ref.watch(blurhashProvider(articles.data[0].imageUrl));
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
        body: Column(
          children: [
            Flexible(
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
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container();
                        },
                      ),
                      text: articles.data[index].title,
                      publishedDate:
                          articles.data[index].publishedAt.split('T')[0],
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
            Container(
              child: MyAdWidget(
                adUnitId: AdUnitId.articlePageBanner,
              ),
            ),
          ],
        ),
      ),
      loading: () => Scaffold(body: flareLoadingAnimation()),
      error: (e, s) => Scaffold(
        body: Center(
          child: Text('Error!, Please restart the app'),
        ),
      ),
    );
  }
}

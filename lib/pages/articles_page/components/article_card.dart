import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:theme_provider/theme_provider.dart';

class ArticleCard extends StatelessWidget {
  ArticleCard({
    this.image,
    this.onPressed,
    this.text = '',
    this.textStyle,
    this.height,
    this.width,
    this.publishedDate = '',
    this.source = '',
  });
  //A widget because you need to use cachedNetworkImage
  final Widget? image;
  final Function? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final String publishedDate;
  final String source;

  @override
  Widget build(BuildContext context) {
    var theme = ThemeProvider.themeOf(context);
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: height ?? (MediaQuery.of(context).size.height) * 0.20,
            width: width ?? (MediaQuery.of(context).size.width) * 0.90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: showBoxShadow(theme.id),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height),
                      width: (MediaQuery.of(context).size.width),
                      child: image,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100,
                        width: (MediaQuery.of(context).size.width),
                        decoration: BoxDecoration(
                          color: theme.data.primaryColor.withOpacity(0.80),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  text!,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style:
                                      theme.data.textTheme.bodyText2?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      'updated: $publishedDate',
                                      overflow: TextOverflow.fade,
                                      style: theme.data.textTheme.caption
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[600]),
                                    ),
                                    SizedBox(width: 10),
                                    AutoSizeText(
                                      'Source: $source',
                                      overflow: TextOverflow.fade,
                                      style: theme.data.textTheme.caption
                                          ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

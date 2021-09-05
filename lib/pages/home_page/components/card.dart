import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:theme_provider/theme_provider.dart';

class DCard extends StatelessWidget {
  DCard({
    this.image,
    this.onPressed,
    this.text = '',
  });
  //A widget because you need to use cachedNetworkImage
  final Widget? image;
  final Function? onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    var theme = ThemeProvider.themeOf(context);
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: (MediaQuery.of(context).size.height) * 0.20,
            width: (MediaQuery.of(context).size.width) * 0.90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black,
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
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        color: Colors.black.withOpacity(0.50),
                        padding: EdgeInsets.all(15.0),
                        height: 60.0,
                        width: 400.0,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: AutoSizeText(
                            text!,
                            textAlign: TextAlign.left,
                            style: theme.data.textTheme.headline6?.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 3,
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

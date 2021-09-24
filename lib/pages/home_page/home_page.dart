import 'package:flutter/material.dart';
import 'package:spaceportal/pages/home_page/components/card_view.dart';
import 'package:spaceportal/routes.dart';
import 'package:spaceportal/services/ad_helper.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:spaceportal/widgets/ad_widget.dart';
import 'package:theme_provider/theme_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = ThemeProvider.themeOf(context);
    return Scaffold(
      body: Container(
        width: (MediaQuery.of(context).size.width),
        height: (MediaQuery.of(context).size.height),
        child: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 10.0),
                    child: Text(
                      'Welcome',
                      style: theme.data.textTheme.headline2,
                    ),
                  ),
                  Container(
                    // color: Colors.pink,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () {
                              ThemeProvider.controllerOf(context).nextTheme();
                            },
                            child: Icon(
                              theme.id == 'sp_dark'
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              color: theme.data.accentColor,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, routeTo(rSettingsPage));
                            },
                            child: Icon(Icons.settings_rounded),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Flexible(
                flex: 2,
                child: Container(
                  height: (MediaQuery.of(context).size.height),
                  child: CardView(),
                ),
              ),
              Container(
                color: Colors.transparent,
                child: Center(
                  child: MyAdWidget(
                    adUnitId: AdUnitId.homePageBanner,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

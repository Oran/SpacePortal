import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyAdWidget extends StatefulWidget {
  MyAdWidget({required this.adUnitId});
  final String adUnitId;

  @override
  _MyAdWidgetState createState() => _MyAdWidgetState();
}

class _MyAdWidgetState extends State<MyAdWidget> {
  late BannerAd _bottomBannerAd;
  bool _isBottomBannerAdLoaded = false;

  void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: widget.adUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print("AD ERROR => " + error.toString());
        },
      ),
    );
    _bottomBannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bottomBannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _bottomBannerAd.size.height.toDouble(),
      width: _bottomBannerAd.size.width.toDouble(),
      child: _isBottomBannerAdLoaded ? AdWidget(ad: _bottomBannerAd) : null,
    );
  }
}

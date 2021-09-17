import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MyAdWidget extends StatefulWidget {
  MyAdWidget({required this.adUnitId});
  final String adUnitId;

  @override
  _MyAdWidgetState createState() => _MyAdWidgetState();
}

class _MyAdWidgetState extends State<MyAdWidget> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  void _createBottomBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: widget.adUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdClosed: (_) {
          setState(() {
            _isAdLoaded = false;
          });
        },
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print("AD ERROR => " + error.toString());
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    _createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Container(
            height: _bannerAd.size.height.toDouble(),
            width: _bannerAd.size.width.toDouble(),
            color: Colors.transparent,
            child: AdWidget(ad: _bannerAd),
          )
        : Container();
  }
}

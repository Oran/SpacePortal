import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class MyAdWidget extends StatefulWidget {
  MyAdWidget({required this.adUnitId});
  final String adUnitId;
  @override
  _MyAdWidgetState createState() => _MyAdWidgetState();
}

class _MyAdWidgetState extends State<MyAdWidget> {
  late BannerAd _bannerAd;
  BannerAdController _controller = BannerAdController();

  void _createBannerAd() {
    _bannerAd = BannerAd(
      unitId: widget.adUnitId,
      controller: _controller,
      builder: (context, child) {
        return Container(
          color: Colors.transparent,
          child: child,
        );
      },
      loading: Text('Ad Loading...'),
      error: Text('Ad Error!'),
      size: BannerSize.BANNER,
    );
    _controller.load();
  }

  @override
  void initState() {
    super.initState();
    _createBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerAd;
  }
}

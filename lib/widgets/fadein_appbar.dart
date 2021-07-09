import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class FadeInAppBar extends StatefulWidget {
  const FadeInAppBar({
    required this.value,
    Key? key,
  }) : super(key: key);

  final String value;

  @override
  _FadeInAppBarState createState() => _FadeInAppBarState();
}

class _FadeInAppBarState extends State<FadeInAppBar> {
  FadeInController _controller = FadeInController(autoStart: true);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.fadeIn();
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      curve: Curves.linearToEaseOut,
      duration: Duration(milliseconds: 250),
      child: BlurHash(
        hash: widget.value,
      ),
    );
  }
}
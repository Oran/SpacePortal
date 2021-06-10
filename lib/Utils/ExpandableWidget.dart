import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Expandable extends StatefulWidget {
  /// • Expandable abstract class for general use.
  Expandable({
    this.primaryWidget,
    this.secondaryWidget,
    this.onPressed,
    this.animationDuration,
    this.beforeAnimationDuration,
    this.initiallyExpanded,
    this.isClickable,
  });

  /// • The widget that is placed at the non-collapsing part of the expandable.
  final Widget? primaryWidget;

  /// • The widget that [sizeTransition] affects.
  final Widget? secondaryWidget;

  /// • Function that is placed top of the widget tree.
  ///
  /// • Animation starts AFTER this function.
  ///
  /// • For the duration between see [beforeAnimationDuration].
  final Function? onPressed;

  /// • Duration for expand & rotate animations.
  final Duration? animationDuration;

  /// • Duration between [onPressed] & expand animation.
  final Duration? beforeAnimationDuration;

  /// • Whether this expandable widget will be expanded or collapsed at first.
  final bool? initiallyExpanded;

  /// • Decide whether this widget will be clickable everywhere or clickable only at [arrowWidget].
  final bool? isClickable;

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<Expandable>
    with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late Animation<double> _sizeAnimation;
  bool _isExpanded = false;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  bool _isRotated = false;
  bool? initiallyExpanded = false;

  static final Animatable<double> _rotationTween = Tween<double>(
    begin: 0.0,
    end: 2,
  );
  static final Animatable<double> _sizeTween = Tween<double>(
    begin: 00,
    end: 1.0,
  );

  _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    switch (_sizeAnimation.status) {
      case AnimationStatus.completed:
        _sizeController.reverse();
        break;
      case AnimationStatus.dismissed:
        _sizeController.forward();
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.forward:
        break;
    }
  }

  _toggleRotate() {
    setState(() {
      _isRotated = !_isRotated;
    });
    switch (_rotationAnimation.status) {
      case AnimationStatus.completed:
        _rotationController.reverse();
        break;
      case AnimationStatus.dismissed:
        _rotationController.forward();
        break;
      case AnimationStatus.reverse:
      case AnimationStatus.forward:
        break;
    }
  }

  @override
  initState() {
    super.initState();
    _sizeController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? Duration(milliseconds: 200),
    );

    _rotationController = AnimationController(
        duration: Duration(milliseconds: 200), vsync: this, lowerBound: 0.5);

    final CurvedAnimation curve =
        CurvedAnimation(parent: _sizeController, curve: Curves.fastOutSlowIn);

    _sizeAnimation = _sizeTween.animate(curve);
    _rotationAnimation = _rotationTween.animate(_rotationController);
    initiallyExpanded = widget.initiallyExpanded;
  }

  @override
  dispose() {
    _sizeController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (initiallyExpanded == true) {
      _toggleExpand();
      initiallyExpanded = false;
    }
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        if (widget.isClickable!) if (widget.onPressed.toString() != 'null') {
          widget.onPressed!();
        }
        if (widget.isClickable!)
          Timer(widget.beforeAnimationDuration ?? Duration(milliseconds: 20),
              () {
            _toggleExpand();
            _toggleRotate();
          });
      },
      child: Container(
        // color: Colors.pink[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // color: Colors.purple[100],
              child: widget.primaryWidget!,
            ),
            Container(
              // color: Colors.blue[100],
              child: Center(
                child: SizeTransition(
                  axisAlignment: 0.0,
                  sizeFactor: _sizeAnimation,
                  child: Center(child: widget.secondaryWidget),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

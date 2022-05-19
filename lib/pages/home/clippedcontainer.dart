import 'package:flutter/material.dart';

import '../../animations/slide_animation.dart';
import '../../utils/ui_helper.dart';

class ClippedContainer extends StatelessWidget {
  const ClippedContainer({
    Key? key,
    required this.child,
    this.height,
    this.backgroundColor,
    this.alignment = Alignment.center,
    this.isAnimated = true,
  }) : super(key: key);

  final Widget child;
  final double? height;
  final bool isAnimated;
  final Color? backgroundColor;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final container = Container(
      height: height,
      // margin: const EdgeInsets.only(left: 5),
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
        color: Colors.white,
      ),
      child: child,
    );

    return isAnimated ?
    SlideAnimation(
      intervalStart: 0.4,
      begin: const Offset(450, 0),
      duration: const Duration(milliseconds: 1250),
      child: container,
    ) :
    container;
  }
}
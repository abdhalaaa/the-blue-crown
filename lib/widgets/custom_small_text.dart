import 'package:flutter/material.dart';
import 'package:theblue_crown/utils/dimensions.dart';

class CustomSmallText extends StatelessWidget {
  final String text;
  final Color color;
  // final Alignment alignment;
  final double height;
  final double size;

  const CustomSmallText({
    Key? key,
    this.text = '',
    this.color = Colors.black,
    // this.alignment = Alignment.topRight,
    this.height = 1.2,
    this.size = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: TextStyle(
        height: height,
        color: color,
        fontSize: size == 0 ? Dimensions.font20 : size,
      ),
    );
  }
}
